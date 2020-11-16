Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39332B4579
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbgKPODH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:03:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41456 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbgKPODH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:03:07 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605535383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yc4QnyU6Tmn0Ov2B4aGIxCJkr23U8e++vXFqll0nDdA=;
        b=0YpOrTtUfUgm5jX6FH4lcv13UGxbpkDg3myQTbPAO11yarF//Sw5E5r1Cznq9yJFesGO5F
        leQ6t8+csp+NJIlv0ep8pDBBjKP9Mw5ZVFynyesl18ouilexj1W1BcuN25qTKC7VUzQu8t
        DhGHwyZB8WR+mRR4IQbllsez8dB0D9+OtYvN/vtE4dOL0noAXOByDISA+k3IYGDJRO0a4/
        EiW62z5fZ9HaZ6WeUQ0ploJK+iWflUbTVCCl7IbJ5bibWa9nA2QaWBDuxn0byny6Og2Qjt
        SkwIFJVt8r3RbcgzVEELJZZ5wQv9MfDN5zXBK+8nL9Ob0K/tS3l61ZVglJCmIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605535383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yc4QnyU6Tmn0Ov2B4aGIxCJkr23U8e++vXFqll0nDdA=;
        b=RByBUCIGuUHG7yp1r8DlubSdIUJf1ahiD5l1OXiEkmNZ60tBrtVozbOTHiFSITt07etSfe
        LZXeh9QvHNgYjQAw==
To:     Arnd Bergmann <arnd@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqdomain: fix -Wshadow warning
In-Reply-To: <20201026162022.3710091-1-arnd@kernel.org>
References: <20201026162022.3710091-1-arnd@kernel.org>
Date:   Mon, 16 Nov 2020 15:03:03 +0100
Message-ID: <87h7ppz9ew.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26 2020 at 17:20, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> When building with W=2, there are tons of warnings about conflicting
> local and global definitions of 'nr_irqs' in common header files:
>
> include/linux/irqdomain.h: In function 'irq_domain_alloc_irqs':
> include/linux/irqdomain.h:482:17: warning: declaration of 'nr_irqs' shadows a global declaration [-Wshadow]
>   482 |    unsigned int nr_irqs, int node, void *arg)
>       |    ~~~~~~~~~~~~~^~~~~~~
> In file included from ../include/linux/interrupt.h:10,
>                  from ../include/linux/kernel_stat.h:9,
>                  from ../include/linux/cgroup.h:26,
>                  from ../include/linux/perf_event.h:57,
>                  from ../include/linux/trace_events.h:10,
>                  from ../include/trace/syscall.h:7,
>                  from ../include/linux/syscalls.h:84,
>                  from ../init/main.c:21:
> include/linux/irqnr.h:8:12: note: shadowed declaration is here
>     8 | extern int nr_irqs;
>       |            ^~~~~~~
>
> Rename the local in irqdomain.h to shut up those warnings

That's lame tinkering. There are gazillion of other functions which have
the very same problem and nr_irqs is used all over the place for local
variables.

So instead of trying to chase all these places we really want to rename
the global 'nr_irqs' variable.

Something like the uncompiled below which is purely mechanical and does
not even try to look at some of the places which use it for the very
wrong reasons and purpose * Shudder *.

Thanks,

        tglx
---
 arch/arm/kernel/irq.c                       |    4 ++--
 arch/powerpc/platforms/cell/axon_msi.c      |    2 +-
 arch/s390/kernel/irq.c                      |    2 +-
 arch/x86/kernel/acpi/boot.c                 |    4 ++--
 arch/x86/kernel/apic/vector.c               |    8 ++++----
 drivers/char/hpet.c                         |    2 +-
 drivers/gpio/gpio-vr41xx.c                  |    2 +-
 drivers/net/ethernet/3com/3c59x.c           |    2 +-
 drivers/net/hamradio/baycom_ser_fdx.c       |    4 ++--
 drivers/net/hamradio/scc.c                  |    6 +++---
 drivers/net/wan/sbni.c                      |    2 +-
 drivers/pcmcia/at91_cf.c                    |    2 +-
 drivers/pcmcia/vrc4171_card.c               |    2 +-
 drivers/scsi/aha152x.c                      |    2 +-
 drivers/sh/intc/virq-debugfs.c              |    2 +-
 drivers/tty/serial/8250/8250_port.c         |    2 +-
 drivers/tty/serial/amba-pl010.c             |    2 +-
 drivers/tty/serial/amba-pl011.c             |    2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |    2 +-
 drivers/tty/serial/serial_core.c            |    2 +-
 drivers/tty/serial/ucc_uart.c               |    2 +-
 drivers/xen/events/events_base.c            |    2 +-
 fs/proc/interrupts.c                        |    4 ++--
 fs/proc/stat.c                              |    4 ++--
 include/linux/irqnr.h                       |   15 +++++++--------
 kernel/irq/irqdesc.c                        |   26 +++++++++++++-------------
 kernel/irq/irqdomain.c                      |    2 +-
 kernel/irq/proc.c                           |    4 ++--
 kernel/irq/resend.c                         |    4 ++--
 29 files changed, 59 insertions(+), 60 deletions(-)

--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -100,7 +100,7 @@ void __init init_IRQ(void)
 #ifdef CONFIG_SPARSE_IRQ
 int __init arch_probe_nr_irqs(void)
 {
-	nr_irqs = machine_desc->nr_irqs ? machine_desc->nr_irqs : NR_IRQS;
-	return nr_irqs;
+	max_nr_irqs = machine_desc->nr_irqs ? machine_desc->nr_irqs : NR_IRQS;
+	return max_nr_irqs;
 }
 #endif
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -111,7 +111,7 @@ static void axon_msi_cascade(struct irq_
 		pr_devel("axon_msi: woff %x roff %x msi %x\n",
 			  write_offset, msic->read_offset, msi);
 
-		if (msi < nr_irqs && irq_get_chip_data(msi) == msic) {
+		if (msi < max_nr_irqs && irq_get_chip_data(msi) == msic) {
 			generic_handle_irq(msi);
 			msic->fifo_virt[idx] = cpu_to_le32(0xffffffff);
 		} else {
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -161,7 +161,7 @@ int show_interrupts(struct seq_file *p,
 		seq_putc(p, '\n');
 		goto out;
 	}
-	if (index < nr_irqs) {
+	if (index < max_nr_irqs) {
 		show_msi_interrupt(p, index);
 		goto out;
 	}
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1195,7 +1195,7 @@ static int __init acpi_parse_madt_ioapic
 	}
 
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_INTERRUPT_OVERRIDE,
-				      acpi_parse_int_src_ovr, nr_irqs);
+				      acpi_parse_int_src_ovr, max_nr_irqs);
 	if (count < 0) {
 		printk(KERN_ERR PREFIX
 		       "Error parsing interrupt source overrides entry\n");
@@ -1216,7 +1216,7 @@ static int __init acpi_parse_madt_ioapic
 	mp_config_acpi_legacy_irqs();
 
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_NMI_SOURCE,
-				      acpi_parse_nmi_src, nr_irqs);
+				      acpi_parse_nmi_src, max_nr_irqs);
 	if (count < 0) {
 		printk(KERN_ERR PREFIX "Error parsing NMI SRC entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -650,8 +650,8 @@ int __init arch_probe_nr_irqs(void)
 {
 	int nr;
 
-	if (nr_irqs > (NR_VECTORS * nr_cpu_ids))
-		nr_irqs = NR_VECTORS * nr_cpu_ids;
+	if (max_nr_irqs > (NR_VECTORS * nr_cpu_ids))
+		max_nr_irqs = NR_VECTORS * nr_cpu_ids;
 
 	nr = (gsi_top + nr_legacy_irqs()) + 8 * nr_cpu_ids;
 #if defined(CONFIG_PCI_MSI)
@@ -663,8 +663,8 @@ int __init arch_probe_nr_irqs(void)
 	else
 		nr += gsi_top * 16;
 #endif
-	if (nr < nr_irqs)
-		nr_irqs = nr;
+	if (nr < max_nr_irqs)
+		max_nr_irqs = nr;
 
 	/*
 	 * We don't know if PIC is present at this point so we need to do
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -230,7 +230,7 @@ static void hpet_timer_set_irq(struct hp
 		v &= ~0xffff;
 
 	for_each_set_bit(irq, &v, HPET_MAX_IRQ) {
-		if (irq >= nr_irqs) {
+		if (irq >= max_nr_irqs) {
 			irq = HPET_MAX_IRQ;
 			break;
 		}
--- a/drivers/gpio/gpio-vr41xx.c
+++ b/drivers/gpio/gpio-vr41xx.c
@@ -517,7 +517,7 @@ static int giu_probe(struct platform_dev
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0 || irq >= nr_irqs)
+	if (irq < 0 || irq >= max_nr_irqs)
 		return -EBUSY;
 
 	return cascade_irq(irq, giu_get_irq);
--- a/drivers/net/ethernet/3com/3c59x.c
+++ b/drivers/net/ethernet/3com/3c59x.c
@@ -1300,7 +1300,7 @@ static int vortex_probe1(struct device *
 	if (print_info)
 		pr_cont(", IRQ %d\n", dev->irq);
 	/* Tell them about an invalid IRQ. */
-	if (dev->irq <= 0 || dev->irq >= nr_irqs)
+	if (dev->irq <= 0 || dev->irq >= max_nr_irqs)
 		pr_warn(" *** Warning: IRQ %d is unlikely to work! ***\n",
 			dev->irq);
 
--- a/drivers/net/hamradio/baycom_ser_fdx.c
+++ b/drivers/net/hamradio/baycom_ser_fdx.c
@@ -379,10 +379,10 @@ static int ser12_open(struct net_device
 	if (!dev || !bc)
 		return -ENXIO;
 	if (!dev->base_addr || dev->base_addr > 0xffff-SER12_EXTENT ||
-	    dev->irq < 2 || dev->irq > nr_irqs) {
+	    dev->irq < 2 || dev->irq > max_nr_irqs) {
 		printk(KERN_INFO "baycom_ser_fdx: invalid portnumber (max %u) "
 				"or irq (2 <= irq <= %d)\n",
-				0xffff-SER12_EXTENT, nr_irqs);
+				0xffff-SER12_EXTENT, max_nr_irqs);
 		return -ENXIO;
 	}
 	if (bc->baud < 300 || bc->baud > 4800) {
--- a/drivers/net/hamradio/scc.c
+++ b/drivers/net/hamradio/scc.c
@@ -1467,7 +1467,7 @@ static void z8530_init(void)
 	printk(KERN_INFO "Init Z8530 driver: %u channels, IRQ", Nchips*2);
 	
 	flag=" ";
-	for (k = 0; k < nr_irqs; k++)
+	for (k = 0; k < max_nr_irqs; k++)
 		if (Ivec[k].used) 
 		{
 			printk("%s%d", flag, k);
@@ -1732,7 +1732,7 @@ static int scc_net_ioctl(struct net_devi
 
 			if (hwcfg.irq == 2) hwcfg.irq = 9;
 
-			if (hwcfg.irq < 0 || hwcfg.irq >= nr_irqs)
+			if (hwcfg.irq < 0 || hwcfg.irq >= max_nr_irqs)
 				return -EINVAL;
 				
 			if (!Ivec[hwcfg.irq].used && hwcfg.irq)
@@ -2137,7 +2137,7 @@ static void __exit scc_cleanup_driver(vo
 		}
 		
 	/* To unload the port must be closed so no real IRQ pending */
-	for (k = 0; k < nr_irqs ; k++)
+	for (k = 0; k < max_nr_irqs ; k++)
 		if (Ivec[k].used) free_irq(k, NULL);
 		
 	local_irq_enable();
--- a/drivers/net/wan/sbni.c
+++ b/drivers/net/wan/sbni.c
@@ -321,7 +321,7 @@ sbni_pci_probe( struct net_device  *dev
 				continue;
 		}
 
-		if (pci_irq_line <= 0 || pci_irq_line >= nr_irqs)
+		if (pci_irq_line <= 0 || pci_irq_line >= max_nr_irqs)
 			pr_warn(
 "WARNING: The PCI BIOS assigned this PCI card to IRQ %d, which is unlikely to work!.\n"
 "You should use the PCI BIOS setup to assign a valid IRQ line.\n",
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -312,7 +312,7 @@ static int at91_cf_probe(struct platform
 			goto fail0a;
 		cf->socket.pci_irq = gpio_to_irq(board->irq_pin);
 	} else
-		cf->socket.pci_irq = nr_irqs + 1;
+		cf->socket.pci_irq = max_nr_irqs + 1;
 
 	/*
 	 * pcmcia layer only remaps "real" memory not iospace
--- a/drivers/pcmcia/vrc4171_card.c
+++ b/drivers/pcmcia/vrc4171_card.c
@@ -628,7 +628,7 @@ static int vrc4171_card_setup(char *opti
 		int irq;
 		options += 4;
 		irq = simple_strtoul(options, &options, 0);
-		if (irq >= 0 && irq < nr_irqs)
+		if (irq >= 0 && irq < max_nr_irqs)
 			vrc4171_irq = irq;
 
 		if (*options != ',')
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -292,7 +292,7 @@ CMD_INC_RESID(struct scsi_cmnd *cmd, int
 #else
 #define IRQ_MIN 9
 #if defined(__PPC)
-#define IRQ_MAX (nr_irqs-1)
+#define IRQ_MAX (max_nr_irqs - 1)
 #else
 #define IRQ_MAX 12
 #endif
--- a/drivers/sh/intc/virq-debugfs.c
+++ b/drivers/sh/intc/virq-debugfs.c
@@ -22,7 +22,7 @@ static int intc_irq_xlate_debug(struct s
 
 	seq_printf(m, "%-5s  %-7s  %-15s\n", "irq", "enum", "chip name");
 
-	for (i = 1; i < nr_irqs; i++) {
+	for (i = 1; i < max_nr_irqs; i++) {
 		struct intc_map_entry *entry = intc_irq_xlate_get(i);
 		struct intc_desc_int *desc = entry->desc;
 
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3152,7 +3152,7 @@ static void serial8250_config_port(struc
 static int
 serial8250_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
-	if (ser->irq >= nr_irqs || ser->irq < 0 ||
+	if (ser->irq >= max_nr_irqs || ser->irq < 0 ||
 	    ser->baud_base < 9600 || ser->type < PORT_UNKNOWN ||
 	    ser->type >= ARRAY_SIZE(uart_config) || ser->type == PORT_CIRRUS ||
 	    ser->type == PORT_STARTECH)
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -530,7 +530,7 @@ static int pl010_verify_port(struct uart
 	int ret = 0;
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_AMBA)
 		ret = -EINVAL;
-	if (ser->irq < 0 || ser->irq >= nr_irqs)
+	if (ser->irq < 0 || ser->irq >= max_nr_irqs)
 		ret = -EINVAL;
 	if (ser->baud_base < 9600)
 		ret = -EINVAL;
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2119,7 +2119,7 @@ static int pl011_verify_port(struct uart
 	int ret = 0;
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_AMBA)
 		ret = -EINVAL;
-	if (ser->irq < 0 || ser->irq >= nr_irqs)
+	if (ser->irq < 0 || ser->irq >= max_nr_irqs)
 		ret = -EINVAL;
 	if (ser->baud_base < 9600)
 		ret = -EINVAL;
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -657,7 +657,7 @@ static int cpm_uart_verify_port(struct u
 
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_CPM)
 		ret = -EINVAL;
-	if (ser->irq < 0 || ser->irq >= nr_irqs)
+	if (ser->irq < 0 || ser->irq >= max_nr_irqs)
 		ret = -EINVAL;
 	if (ser->baud_base < 9600)
 		ret = -EINVAL;
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -875,7 +875,7 @@ static int uart_set_info(struct tty_stru
 	if (uport->ops->verify_port)
 		retval = uport->ops->verify_port(uport, new_info);
 
-	if ((new_info->irq >= nr_irqs) || (new_info->irq < 0) ||
+	if ((new_info->irq >= max_nr_irqs) || (new_info->irq < 0) ||
 	    (new_info->baud_base < 9600))
 		retval = -EINVAL;
 
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1065,7 +1065,7 @@ static int qe_uart_verify_port(struct ua
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_CPM)
 		return -EINVAL;
 
-	if (ser->irq < 0 || ser->irq >= nr_irqs)
+	if (ser->irq < 0 || ser->irq >= max_nr_irqs)
 		return -EINVAL;
 
 	if (ser->baud_base < 9600)
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -348,7 +348,7 @@ evtchn_port_t evtchn_from_irq(unsigned i
 {
 	const struct irq_info *info = NULL;
 
-	if (likely(irq < nr_irqs))
+	if (likely(irq < max_nr_irqs))
 		info = info_for_irq(irq);
 	if (!info)
 		return 0;
--- a/fs/proc/interrupts.c
+++ b/fs/proc/interrupts.c
@@ -11,13 +11,13 @@
  */
 static void *int_seq_start(struct seq_file *f, loff_t *pos)
 {
-	return (*pos <= nr_irqs) ? pos : NULL;
+	return (*pos <= max_nr_irqs) ? pos : NULL;
 }
 
 static void *int_seq_next(struct seq_file *f, void *v, loff_t *pos)
 {
 	(*pos)++;
-	if (*pos > nr_irqs)
+	if (*pos > max_nr_irqs)
 		return NULL;
 	return pos;
 }
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -101,7 +101,7 @@ static void show_all_irqs(struct seq_fil
 		seq_put_decimal_ull(p, " ", kstat_irqs_usr(i));
 		next = i + 1;
 	}
-	show_irq_gap(p, nr_irqs - next);
+	show_irq_gap(p, max_nr_irqs - next);
 }
 
 static int show_stat(struct seq_file *p, void *v)
@@ -219,7 +219,7 @@ static int stat_open(struct inode *inode
 	unsigned int size = 1024 + 128 * num_online_cpus();
 
 	/* minimum size to display an interrupt count : 2 bytes */
-	size += 2 * nr_irqs;
+	size += 2 * max_nr_irqs;
 	return single_open_size(file, show_stat, NULL, size);
 }
 
--- a/include/linux/irqnr.h
+++ b/include/linux/irqnr.h
@@ -4,13 +4,12 @@
 
 #include <uapi/linux/irqnr.h>
 
-
-extern int nr_irqs;
+extern int max_nr_irqs;
 extern struct irq_desc *irq_to_desc(unsigned int irq);
 unsigned int irq_get_next_irq(unsigned int offset);
 
 # define for_each_irq_desc(irq, desc)					\
-	for (irq = 0, desc = irq_to_desc(irq); irq < nr_irqs;		\
+	for (irq = 0, desc = irq_to_desc(irq); irq < max_nr_irqs;	\
 	     irq++, desc = irq_to_desc(irq))				\
 		if (!desc)						\
 			;						\
@@ -18,17 +17,17 @@ unsigned int irq_get_next_irq(unsigned i
 
 
 # define for_each_irq_desc_reverse(irq, desc)				\
-	for (irq = nr_irqs - 1, desc = irq_to_desc(irq); irq >= 0;	\
+	for (irq = max_nr_irqs - 1, desc = irq_to_desc(irq); irq >= 0;	\
 	     irq--, desc = irq_to_desc(irq))				\
 		if (!desc)						\
 			;						\
 		else
 
-# define for_each_active_irq(irq)			\
-	for (irq = irq_get_next_irq(0); irq < nr_irqs;	\
+# define for_each_active_irq(irq)				\
+	for (irq = irq_get_next_irq(0); irq < max_nr_irqs;	\
 	     irq = irq_get_next_irq(irq + 1))
 
-#define for_each_irq_nr(irq)                   \
-       for (irq = 0; irq < nr_irqs; irq++)
+#define for_each_irq_nr(irq)			\
+       for (irq = 0; irq < max_nr_irqs; irq++)
 
 #endif
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -127,8 +127,8 @@ static void desc_set_defaults(unsigned i
 	desc_smp_init(desc, node, affinity);
 }
 
-int nr_irqs = NR_IRQS;
-EXPORT_SYMBOL_GPL(nr_irqs);
+int max_nr_irqs = NR_IRQS;
+EXPORT_SYMBOL_GPL(max_nr_irqs);
 
 static DEFINE_MUTEX(sparse_irq_lock);
 static DECLARE_BITMAP(allocated_irqs, IRQ_BITMAP_BITS);
@@ -512,7 +512,7 @@ static int irq_expand_nr_irqs(unsigned i
 {
 	if (nr > IRQ_BITMAP_BITS)
 		return -ENOMEM;
-	nr_irqs = nr;
+	max_nr_irqs = nr;
 	return 0;
 }
 
@@ -526,16 +526,16 @@ int __init early_irq_init(void)
 	/* Let arch update nr_irqs and return the nr of preallocated irqs */
 	initcnt = arch_probe_nr_irqs();
 	printk(KERN_INFO "NR_IRQS: %d, nr_irqs: %d, preallocated irqs: %d\n",
-	       NR_IRQS, nr_irqs, initcnt);
+	       NR_IRQS, max_nr_irqs, initcnt);
 
-	if (WARN_ON(nr_irqs > IRQ_BITMAP_BITS))
-		nr_irqs = IRQ_BITMAP_BITS;
+	if (WARN_ON(max_nr_irqs > IRQ_BITMAP_BITS))
+		max_nr_irqs = IRQ_BITMAP_BITS;
 
 	if (WARN_ON(initcnt > IRQ_BITMAP_BITS))
 		initcnt = IRQ_BITMAP_BITS;
 
-	if (initcnt > nr_irqs)
-		nr_irqs = initcnt;
+	if (initcnt > max_nr_irqs)
+		max_nr_irqs = initcnt;
 
 	for (i = 0; i < initcnt; i++) {
 		desc = alloc_desc(i, node, 0, NULL, NULL);
@@ -680,7 +680,7 @@ int __handle_domain_irq(struct irq_domai
 	 * Some hardware gives randomly wrong interrupts.  Rather
 	 * than crashing, do something sensible.
 	 */
-	if (unlikely(!irq || irq >= nr_irqs)) {
+	if (unlikely(!irq || irq >= max_nr_irqs)) {
 		ack_bad_irq(irq);
 		ret = -EINVAL;
 	} else {
@@ -743,7 +743,7 @@ void irq_free_descs(unsigned int from, u
 {
 	int i;
 
-	if (from >= nr_irqs || (from + cnt) > nr_irqs)
+	if (from >= max_nr_irqs || (from + cnt) > max_nr_irqs)
 		return;
 
 	mutex_lock(&sparse_irq_lock);
@@ -798,7 +798,7 @@ int __ref
 	if (irq >=0 && start != irq)
 		goto unlock;
 
-	if (start + cnt > nr_irqs) {
+	if (start + cnt > max_nr_irqs) {
 		ret = irq_expand_nr_irqs(start + cnt);
 		if (ret)
 			goto unlock;
@@ -814,11 +814,11 @@ EXPORT_SYMBOL_GPL(__irq_alloc_descs);
  * irq_get_next_irq - get next allocated irq number
  * @offset:	where to start the search
  *
- * Returns next irq number after offset or nr_irqs if none is found.
+ * Returns next irq number after offset or max_nr_irqs if none is found.
  */
 unsigned int irq_get_next_irq(unsigned int offset)
 {
-	return find_next_bit(allocated_irqs, nr_irqs, offset);
+	return find_next_bit(allocated_irqs, max_nr_irqs, offset);
 }
 
 struct irq_desc *
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1030,7 +1030,7 @@ int irq_domain_alloc_descs(int virq, uns
 		virq = __irq_alloc_descs(virq, virq, cnt, node, THIS_MODULE,
 					 affinity);
 	} else {
-		hint = hwirq % nr_irqs;
+		hint = hwirq % max_nr_irqs;
 		if (hint == 0)
 			hint++;
 		virq = __irq_alloc_descs(-1, hint, cnt, node, THIS_MODULE,
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -454,7 +454,7 @@ int __weak arch_show_interrupts(struct s
 }
 
 #ifndef ACTUAL_NR_IRQS
-# define ACTUAL_NR_IRQS nr_irqs
+# define ACTUAL_NR_IRQS max_nr_irqs
 #endif
 
 int show_interrupts(struct seq_file *p, void *v)
@@ -474,7 +474,7 @@ int show_interrupts(struct seq_file *p,
 
 	/* print header and calculate the width of the first column */
 	if (i == 0) {
-		for (prec = 3, j = 1000; prec < 10 && j <= nr_irqs; ++prec)
+		for (prec = 3, j = 1000; prec < 10 && j <= max_nr_irqs; ++prec)
 			j *= 10;
 
 		seq_printf(p, "%*s", prec + 8, "");
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -32,8 +32,8 @@ static void resend_irqs(unsigned long ar
 	struct irq_desc *desc;
 	int irq;
 
-	while (!bitmap_empty(irqs_resend, nr_irqs)) {
-		irq = find_first_bit(irqs_resend, nr_irqs);
+	while (!bitmap_empty(irqs_resend, max_nr_irqs)) {
+		irq = find_first_bit(irqs_resend, max_nr_irqs);
 		clear_bit(irq, irqs_resend);
 		desc = irq_to_desc(irq);
 		if (!desc)
