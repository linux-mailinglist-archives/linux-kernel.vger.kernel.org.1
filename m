Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46E62AB3F0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgKIJr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:47:26 -0500
Received: from ozlabs.ru ([107.174.27.60]:52316 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgKIJr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:47:26 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 8D4B7AE80013;
        Mon,  9 Nov 2020 04:46:50 -0500 (EST)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@lca.pw>,
        Rob Herring <robh@kernel.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>
Subject: [PATCH kernel v3] genirq/irqdomain: Add reference counting to IRQs
Date:   Mon,  9 Nov 2020 20:46:46 +1100
Message-Id: <20201109094646.71565-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI devices share 4 legacy INTx interrupts from the same PCI host bridge.
Device drivers map/unmap hardware interrupts via irq_create_mapping()/
irq_dispose_mapping(). The problem with that these interrupts are
shared and when performing hot unplug, we need to unmap the interrupt
only when the last device is released.

This reuses already existing irq_desc::kobj for this purpose.
The refcounter is naturally 1 when the descriptor is allocated already;
this adds kobject_get() in places where already existing mapped virq
is returned.

This reorganizes irq_dispose_mapping() to release the kobj and let
the release callback do the cleanup.

As kobject_put() is called directly now (not via RCU), it can also handle
the early boot case (irq_kobj_base==NULL) with the help of
the kobject::state_in_sysfs flag and without additional irq_sysfs_del().
While at this, clean up the comment at where irq_sysfs_del() was called.

Quick grep shows no sign of irq reference counting in drivers. Drivers
typically request mapping when probing and dispose it when removing;
platforms tend to dispose only if setup failed and the rest seems
calling one dispose per one mapping. Except (at least) PPC/pseries
which needs https://lkml.org/lkml/2020/10/27/259

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Qian Cai <cai@lca.pw>
Cc: Rob Herring <robh@kernel.org>
Cc: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Michal Suchánek <msuchanek@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is what it is fixing for powerpc:

There was a comment about whether hierarchical IRQ domains should
contribute to this reference counter and I need some help here as
I cannot see why.
It is reverse now - IRQs contribute to domain->mapcount and
irq_domain_associate/irq_domain_disassociate take necessary steps to
keep this counter in order. What might be missing is that if we have
cascade of IRQs (as in the IOAPIC example from
Documentation/core-api/irq/irq-domain.rst ), then a parent IRQ should
contribute to the children IRQs and it is up to
irq_domain_ops::alloc/free hooks, and they all seem to be eventually
calling irq_domain_alloc_irqs_xxx/irq_domain_free_irqs_xxx which seems
right.

Documentation/core-api/irq/irq-domain.rst also suggests there is a lot
to see in debugfs about IRQs but on my thinkpad there nothing about
hierarchy.

So I'll ask again :)

What is the easiest way to get irq-hierarchical hardware?
I have a bunch of powerpc boxes (no good) but also a raspberry pi,
a bunch of 32/64bit orange pi's, an "armada" arm box,
thinkpads - is any of this good for the task?



---
Changes:
v3:
* removed very wrong kobject_get/_put from irq_domain_associate/
irq_domain_disassociate as these are called from kobject_release so
irq_descs were never actually released
* removed irq_sysfs_del as 1) we do not seem to need it with changed
counting  2) produces a "no parent" warning as it would be called from
kobject_release which removes sysfs nodes itself

v2:
* added more get/put, including irq_domain_associate/irq_domain_disassociate
---
 kernel/irq/irqdesc.c   | 55 ++++++++++++++++++------------------------
 kernel/irq/irqdomain.c | 37 ++++++++++++++++------------
 2 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 1a7723604399..79c904ebfd5c 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -295,18 +295,6 @@ static void irq_sysfs_add(int irq, struct irq_desc *desc)
 	}
 }
 
-static void irq_sysfs_del(struct irq_desc *desc)
-{
-	/*
-	 * If irq_sysfs_init() has not yet been invoked (early boot), then
-	 * irq_kobj_base is NULL and the descriptor was never added.
-	 * kobject_del() complains about a object with no parent, so make
-	 * it conditional.
-	 */
-	if (irq_kobj_base)
-		kobject_del(&desc->kobj);
-}
-
 static int __init irq_sysfs_init(void)
 {
 	struct irq_desc *desc;
@@ -337,7 +325,6 @@ static struct kobj_type irq_kobj_type = {
 };
 
 static void irq_sysfs_add(int irq, struct irq_desc *desc) {}
-static void irq_sysfs_del(struct irq_desc *desc) {}
 
 #endif /* CONFIG_SYSFS */
 
@@ -419,20 +406,40 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 	return NULL;
 }
 
+static void delayed_free_desc(struct rcu_head *rhp);
 static void irq_kobj_release(struct kobject *kobj)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
+#ifdef CONFIG_IRQ_DOMAIN
+	struct irq_domain *domain;
+	unsigned int virq = desc->irq_data.irq;
 
-	free_masks(desc);
-	free_percpu(desc->kstat_irqs);
-	kfree(desc);
+	domain = desc->irq_data.domain;
+	if (domain) {
+		if (irq_domain_is_hierarchy(domain)) {
+			irq_domain_free_irqs(virq, 1);
+		} else {
+			irq_domain_disassociate(domain, virq);
+			irq_free_desc(virq);
+		}
+	}
+#endif
+	/*
+	 * We free the descriptor, masks and stat fields via RCU. That
+	 * allows demultiplex interrupts to do rcu based management of
+	 * the child interrupts.
+	 * This also allows us to use rcu in kstat_irqs_usr().
+	 */
+	call_rcu(&desc->rcu, delayed_free_desc);
 }
 
 static void delayed_free_desc(struct rcu_head *rhp)
 {
 	struct irq_desc *desc = container_of(rhp, struct irq_desc, rcu);
 
-	kobject_put(&desc->kobj);
+	free_masks(desc);
+	free_percpu(desc->kstat_irqs);
+	kfree(desc);
 }
 
 static void free_desc(unsigned int irq)
@@ -443,24 +450,10 @@ static void free_desc(unsigned int irq)
 	unregister_irq_proc(irq, desc);
 
 	/*
-	 * sparse_irq_lock protects also show_interrupts() and
-	 * kstat_irq_usr(). Once we deleted the descriptor from the
-	 * sparse tree we can free it. Access in proc will fail to
-	 * lookup the descriptor.
-	 *
 	 * The sysfs entry must be serialized against a concurrent
 	 * irq_sysfs_init() as well.
 	 */
-	irq_sysfs_del(desc);
 	delete_irq_desc(irq);
-
-	/*
-	 * We free the descriptor, masks and stat fields via RCU. That
-	 * allows demultiplex interrupts to do rcu based management of
-	 * the child interrupts.
-	 * This also allows us to use rcu in kstat_irqs_usr().
-	 */
-	call_rcu(&desc->rcu, delayed_free_desc);
 }
 
 static int alloc_descs(unsigned int start, unsigned int cnt, int node,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cf8b374b892d..d79d679bec35 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -638,6 +638,7 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 {
 	struct device_node *of_node;
 	int virq;
+	struct irq_desc *desc;
 
 	pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
 
@@ -655,7 +656,9 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 	/* Check if mapping already exists */
 	virq = irq_find_mapping(domain, hwirq);
 	if (virq) {
+		desc = irq_to_desc(virq);
 		pr_debug("-> existing mapping on virq %d\n", virq);
+		kobject_get(&desc->kobj);
 		return virq;
 	}
 
@@ -751,6 +754,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
 	int virq;
+	struct irq_desc *desc;
 
 	if (fwspec->fwnode) {
 		domain = irq_find_matching_fwspec(fwspec, DOMAIN_BUS_WIRED);
@@ -787,8 +791,11 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 		 * current trigger type then we are done so return the
 		 * interrupt number.
 		 */
-		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
+		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq)) {
+			desc = irq_to_desc(virq);
+			kobject_get(&desc->kobj);
 			return virq;
+		}
 
 		/*
 		 * If the trigger type has not been set yet, then set
@@ -800,6 +807,8 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 				return 0;
 
 			irqd_set_trigger_type(irq_data, type);
+			desc = irq_to_desc(virq);
+			kobject_get(&desc->kobj);
 			return virq;
 		}
 
@@ -852,22 +861,12 @@ EXPORT_SYMBOL_GPL(irq_create_of_mapping);
  */
 void irq_dispose_mapping(unsigned int virq)
 {
-	struct irq_data *irq_data = irq_get_irq_data(virq);
-	struct irq_domain *domain;
+	struct irq_desc *desc = irq_to_desc(virq);
 
-	if (!virq || !irq_data)
+	if (!virq || !desc)
 		return;
 
-	domain = irq_data->domain;
-	if (WARN_ON(domain == NULL))
-		return;
-
-	if (irq_domain_is_hierarchy(domain)) {
-		irq_domain_free_irqs(virq, 1);
-	} else {
-		irq_domain_disassociate(domain, virq);
-		irq_free_desc(virq);
-	}
+	kobject_put(&desc->kobj);
 }
 EXPORT_SYMBOL_GPL(irq_dispose_mapping);
 
@@ -1413,6 +1412,7 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 			    bool realloc, const struct irq_affinity_desc *affinity)
 {
 	int i, ret, virq;
+	bool get_ref = false;
 
 	if (domain == NULL) {
 		domain = irq_default_domain;
@@ -1422,6 +1422,7 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 
 	if (realloc && irq_base >= 0) {
 		virq = irq_base;
+		get_ref = true;
 	} else {
 		virq = irq_domain_alloc_descs(irq_base, nr_irqs, 0, node,
 					      affinity);
@@ -1453,8 +1454,14 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 		}
 	}
 	
-	for (i = 0; i < nr_irqs; i++)
+	for (i = 0; i < nr_irqs; i++) {
 		irq_domain_insert_irq(virq + i);
+		if (get_ref) {
+			struct irq_desc *desc = irq_to_desc(virq + i);
+
+			kobject_get(&desc->kobj);
+		}
+	}
 	mutex_unlock(&irq_domain_mutex);
 
 	return virq;
-- 
2.17.1

