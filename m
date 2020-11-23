Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9182C04B5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgKWLiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:38:14 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:54449 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728897AbgKWLiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:38:13 -0500
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.52 with ESMTP; 23 Nov 2020 20:38:06 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.222.33)
        by 156.147.1.127 with ESMTP; 23 Nov 2020 20:38:06 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com
Subject: [RFC 6/6] dept: Assign custom dept_keys or disable to avoid false positives
Date:   Mon, 23 Nov 2020 20:36:32 +0900
Message-Id: <1606131392-22645-6-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1606131392-22645-1-git-send-email-byungchul.park@lge.com>
References: <20201123110527.GB9464@X58A-UD3R>
 <1606131392-22645-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 arch/arm/mach-omap2/omap_hwmod.c                   |  6 +++++
 arch/powerpc/platforms/powermac/low_i2c.c          | 15 +++++++++++
 block/blk-flush.c                                  |  3 +++
 block/blk.h                                        |  1 +
 drivers/base/class.c                               | 13 +++++-----
 drivers/base/core.c                                |  1 +
 drivers/base/regmap/regmap.c                       | 10 ++++++++
 drivers/fpga/dfl.c                                 |  3 +++
 drivers/gpio/gpio-pca953x.c                        |  2 ++
 drivers/gpu/drm/etnaviv/etnaviv_gem.c              |  6 +++++
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c        |  3 +++
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  3 +++
 drivers/gpu/drm/i915/gt/intel_gtt.c                |  1 +
 drivers/gpu/drm/i915/i915_active.c                 |  8 +++---
 drivers/gpu/drm/i915/i915_active.h                 |  6 +++--
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c         |  7 +++--
 drivers/input/mousedev.c                           |  2 ++
 drivers/input/serio/libps2.c                       |  1 +
 drivers/input/serio/serio.c                        |  1 +
 drivers/macintosh/mac_hid.c                        |  6 +++++
 drivers/md/bcache/btree.c                          |  1 +
 drivers/media/v4l2-core/v4l2-ctrls.c               |  5 +++-
 .../ethernet/netronome/nfp/nfpcore/nfp_cppcore.c   |  2 ++
 drivers/net/team/team.c                            |  5 ++++
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |  3 +++
 drivers/s390/char/raw3270.c                        |  1 +
 drivers/s390/cio/cio.c                             |  2 ++
 drivers/s390/net/qeth_core_main.c                  |  3 +++
 drivers/tty/serial/ifx6x60.c                       |  2 ++
 drivers/tty/serial/serial_core.c                   |  2 ++
 drivers/tty/tty_buffer.c                           |  1 +
 drivers/tty/tty_mutex.c                            |  1 +
 drivers/usb/storage/usb.c                          |  2 ++
 fs/btrfs/disk-io.c                                 |  3 +++
 fs/dcache.c                                        |  1 +
 fs/inode.c                                         |  6 +++++
 fs/ntfs/inode.c                                    |  5 ++++
 fs/ntfs/super.c                                    |  6 +++++
 fs/overlayfs/inode.c                               |  3 +++
 fs/super.c                                         |  6 +++++
 fs/xfs/xfs_dquot.c                                 |  4 +++
 include/linux/device/class.h                       | 24 +++++++++--------
 include/linux/if_team.h                            |  1 +
 include/linux/irqdesc.h                            |  6 +++++
 include/linux/kthread.h                            |  6 +++--
 include/linux/percpu_counter.h                     |  6 +++--
 include/linux/skbuff.h                             |  4 ++-
 include/linux/swait.h                              |  6 +++--
 include/media/v4l2-ctrls.h                         |  8 ++++--
 include/net/sock.h                                 |  1 +
 kernel/events/core.c                               |  4 +++
 kernel/irq/irqdesc.c                               |  3 +++
 kernel/kthread.c                                   |  4 ++-
 kernel/rcu/tree.c                                  |  6 +++++
 kernel/sched/sched.h                               |  1 +
 kernel/sched/swait.c                               |  4 ++-
 kernel/sched/wait.c                                |  4 +++
 kernel/trace/ring_buffer.c                         |  4 +++
 kernel/workqueue.c                                 |  1 +
 lib/locking-selftest.c                             | 15 ++++++-----
 lib/percpu_counter.c                               |  4 ++-
 mm/list_lru.c                                      |  8 +++++-
 net/batman-adv/hash.c                              |  7 ++++-
 net/core/dev.c                                     |  7 +++++
 net/core/neighbour.c                               |  4 ++-
 net/core/sock.c                                    | 30 ++++++++++++++++++++--
 net/l2tp/l2tp_core.c                               |  3 +++
 net/netfilter/ipvs/ip_vs_sync.c                    |  7 +++--
 net/netlink/af_netlink.c                           |  4 +++
 net/rxrpc/call_object.c                            |  6 ++++-
 net/sched/sch_generic.c                            |  6 +++++
 71 files changed, 298 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 15b29a1..7fc1c98 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2604,6 +2604,12 @@ static int _register(struct omap_hwmod *oh)
 	INIT_LIST_HEAD(&oh->slave_ports);
 	spin_lock_init(&oh->_lock);
 	lockdep_set_class(&oh->_lock, &oh->hwmod_key);
+	/*
+	 * TODO: Should re-initialize the map with a valid dept_key.
+	 * Also needs dept_key_init() before using it, dept_key_destroy()
+	 * before freeing it.
+	 */
+	dept_spin_nocheck(&oh->_lock.dmap);
 
 	oh->_state = _HWMOD_STATE_REGISTERED;
 
diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 126c60a..640eeb2 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -583,6 +583,11 @@ static void __init kw_i2c_add(struct pmac_i2c_host_kw *host,
 	bus->xfer = kw_i2c_xfer;
 	mutex_init(&bus->mutex);
 	lockdep_set_class(&bus->mutex, &bus->lock_key);
+	/*
+	 * TODO: Should re-initialize the map with a valid dept_key.
+	 * Also need dept_key_init() before using it.
+	 */
+	dept_mutex_nocheck(&bus->mutex.dmap);
 	if (controller == busnode)
 		bus->flags = pmac_i2c_multibus;
 	list_add(&bus->link, &pmac_i2c_busses);
@@ -811,6 +816,11 @@ static void __init pmu_i2c_probe(void)
 		bus->xfer = pmu_i2c_xfer;
 		mutex_init(&bus->mutex);
 		lockdep_set_class(&bus->mutex, &bus->lock_key);
+		/*
+		 * TODO: Should re-initialize the map with a valid dept_key.
+		 * Also need dept_key_init() before using it.
+		 */
+		dept_mutex_nocheck(&bus->mutex.dmap);
 		bus->flags = pmac_i2c_multibus;
 		list_add(&bus->link, &pmac_i2c_busses);
 
@@ -934,6 +944,11 @@ static void __init smu_i2c_probe(void)
 		bus->xfer = smu_i2c_xfer;
 		mutex_init(&bus->mutex);
 		lockdep_set_class(&bus->mutex, &bus->lock_key);
+		/*
+		 * TODO: Should re-initialize the map with a valid dept_key.
+		 * Also need dept_key_init() before using it.
+		 */
+		dept_mutex_nocheck(&bus->mutex.dmap);
 		bus->flags = 0;
 		list_add(&bus->link, &pmac_i2c_busses);
 
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 53abb5c..d283d8f 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -469,7 +469,9 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 	INIT_LIST_HEAD(&fq->flush_data_in_flight);
 
 	lockdep_register_key(&fq->key);
+	dept_key_init(&fq->dkey);
 	lockdep_set_class(&fq->mq_flush_lock, &fq->key);
+	dept_spin_reinit(&fq->mq_flush_lock.dmap, &fq->dkey, -1, NULL);
 
 	return fq;
 
@@ -486,6 +488,7 @@ void blk_free_flush_queue(struct blk_flush_queue *fq)
 		return;
 
 	lockdep_unregister_key(&fq->key);
+	dept_key_destroy(&fq->dkey);
 	kfree(fq->flush_rq);
 	kfree(fq);
 }
diff --git a/block/blk.h b/block/blk.h
index 49e2928..15eaef2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -26,6 +26,7 @@ struct blk_flush_queue {
 	struct request		*flush_rq;
 
 	struct lock_class_key	key;
+	struct dept_key		dkey;
 	spinlock_t		mq_flush_lock;
 };
 
diff --git a/drivers/base/class.c b/drivers/base/class.c
index c52ee21a..aa36756 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -150,7 +150,8 @@ static void class_remove_groups(struct class *cls,
 	return sysfs_remove_groups(&cls->p->subsys.kobj, groups);
 }
 
-int __class_register(struct class *cls, struct lock_class_key *key)
+int __class_register(struct class *cls, struct lock_class_key *key,
+		     struct dept_key *dkey)
 {
 	struct subsys_private *cp;
 	int error;
@@ -163,10 +164,7 @@ int __class_register(struct class *cls, struct lock_class_key *key)
 	klist_init(&cp->klist_devices, klist_class_dev_get, klist_class_dev_put);
 	INIT_LIST_HEAD(&cp->interfaces);
 	kset_init(&cp->glue_dirs);
-	/*
-	 * TODO: Initialize the mutex with a valid dept_key.
-	 */
-	__mutex_init(&cp->mutex, "subsys mutex", key, NULL);
+	__mutex_init(&cp->mutex, "subsys mutex", key, dkey);
 	error = kobject_set_name(&cp->subsys.kobj, "%s", cls->name);
 	if (error) {
 		kfree(cp);
@@ -227,7 +225,8 @@ static void class_create_release(struct class *cls)
  * making a call to class_destroy().
  */
 struct class *__class_create(struct module *owner, const char *name,
-			     struct lock_class_key *key)
+			     struct lock_class_key *key,
+			     struct dept_key *dkey)
 {
 	struct class *cls;
 	int retval;
@@ -242,7 +241,7 @@ struct class *__class_create(struct module *owner, const char *name,
 	cls->owner = owner;
 	cls->class_release = class_create_release;
 
-	retval = __class_register(cls, key);
+	retval = __class_register(cls, key, dkey);
 	if (retval)
 		goto error;
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index bb5806a..f127f7e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2408,6 +2408,7 @@ void device_initialize(struct device *dev)
 	mutex_init(&dev->lockdep_mutex);
 #endif
 	lockdep_set_novalidate_class(&dev->mutex);
+	dept_mutex_nocheck(&dev->mutex.dmap);
 	spin_lock_init(&dev->devres_lock);
 	INIT_LIST_HEAD(&dev->devres_head);
 	device_pm_init(dev);
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index b71f9ec..fdfb2b7 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -749,12 +749,22 @@ struct regmap *__regmap_init(struct device *dev,
 			map->unlock = regmap_unlock_spinlock;
 			lockdep_set_class_and_name(&map->spinlock,
 						   lock_key, lock_name);
+			/*
+			 * TODO: Should re-initialize the map with a valid
+			 * dept_key.
+			 */
+			dept_spin_nocheck(&map->spinlock.dmap);
 		} else {
 			mutex_init(&map->mutex);
 			map->lock = regmap_lock_mutex;
 			map->unlock = regmap_unlock_mutex;
 			lockdep_set_class_and_name(&map->mutex,
 						   lock_key, lock_name);
+			/*
+			 * TODO: Should re-initialize the map with a valid
+			 * dept_key.
+			 */
+			dept_mutex_nocheck(&map->mutex.dmap);
 		}
 		map->lock_arg = map;
 	}
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 649958a..dd947af 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -43,6 +43,7 @@ enum dfl_fpga_devt_type {
 };
 
 static struct lock_class_key dfl_pdata_keys[DFL_ID_MAX];
+static struct dept_key dfl_pdata_dkeys[DFL_ID_MAX];
 
 static const char *dfl_pdata_key_strings[DFL_ID_MAX] = {
 	"dfl-fme-pdata",
@@ -510,6 +511,8 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 	mutex_init(&pdata->lock);
 	lockdep_set_class_and_name(&pdata->lock, &dfl_pdata_keys[type],
 				   dfl_pdata_key_strings[type]);
+	dept_spin_reinit(&pdata->lock.dmap, &dfl_pdata_dkeys[type], -1,
+				   dfl_pdata_key_strings[type]);
 
 	/*
 	 * the count should be initialized to 0 to make sure
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index c2d6121..fdedd20 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1084,6 +1084,8 @@ static int pca953x_probe(struct i2c_client *client,
 	 */
 	lockdep_set_subclass(&chip->i2c_lock,
 			     i2c_adapter_depth(client->adapter));
+	dept_mutex_reinit(&chip->i2c_lock.dmap, NULL,
+			  i2c_adapter_depth(client->adapter), NULL);
 
 	/* initialize cached registers from their original values.
 	 * we can't share this chip with another i2c master.
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index f06e19e..48a2d1f 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -16,6 +16,8 @@
 
 static struct lock_class_key etnaviv_shm_lock_class;
 static struct lock_class_key etnaviv_userptr_lock_class;
+static struct dept_key etnaviv_shm_dkey;
+static struct dept_key etnaviv_userptr_dkey;
 
 static void etnaviv_gem_scatter_map(struct etnaviv_gem_object *etnaviv_obj)
 {
@@ -614,6 +616,8 @@ int etnaviv_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 		goto fail;
 
 	lockdep_set_class(&to_etnaviv_bo(obj)->lock, &etnaviv_shm_lock_class);
+	dept_mutex_reinit(&to_etnaviv_bo(obj)->lock.dmap,
+			  &etnaviv_shm_dkey, -1, NULL);
 
 	ret = drm_gem_object_init(dev, obj, size);
 	if (ret)
@@ -732,6 +736,8 @@ int etnaviv_gem_new_userptr(struct drm_device *dev, struct drm_file *file,
 		return ret;
 
 	lockdep_set_class(&etnaviv_obj->lock, &etnaviv_userptr_lock_class);
+	dept_mutex_reinit(&etnaviv_obj->lock.dmap,
+			  &etnaviv_userptr_dkey, -1, NULL);
 
 	etnaviv_obj->userptr.ptr = ptr;
 	etnaviv_obj->userptr.mm = current->mm;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index 6d9e5c3..d45b191 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -10,6 +10,7 @@
 #include "etnaviv_gem.h"
 
 static struct lock_class_key etnaviv_prime_lock_class;
+static struct dept_key etnaviv_prime_dkey;
 
 struct sg_table *etnaviv_gem_prime_get_sg_table(struct drm_gem_object *obj)
 {
@@ -116,6 +117,8 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
 		return ERR_PTR(ret);
 
 	lockdep_set_class(&etnaviv_obj->lock, &etnaviv_prime_lock_class);
+	dept_mutex_reinit(&etnaviv_obj->lock.dmap,
+			  &etnaviv_prime_dkey, -1, NULL);
 
 	npages = size / PAGE_SIZE;
 
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index 26087dd..e5a7f0f 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -770,6 +770,7 @@ static int measure_breadcrumb_dw(struct intel_context *ce)
 
 	spin_lock_init(&engine->active.lock);
 	lockdep_set_subclass(&engine->active.lock, subclass);
+	dept_spin_reinit(&engine->active.lock.dmap, NULL, subclass, NULL);
 
 	/*
 	 * Due to an interesting quirk in lockdep's internal debug tracking,
@@ -788,6 +789,7 @@ static int measure_breadcrumb_dw(struct intel_context *ce)
 create_kernel_context(struct intel_engine_cs *engine)
 {
 	static struct lock_class_key kernel;
+	static struct dept_key kernel_dkey;
 	struct intel_context *ce;
 	int err;
 
@@ -810,6 +812,7 @@ static int measure_breadcrumb_dw(struct intel_context *ce)
 	 * construction.
 	 */
 	lockdep_set_class(&ce->timeline->mutex, &kernel);
+	dept_mutex_reinit(&ce->timeline->mutex.dmap, &kernel_dkey, -1, NULL);
 
 	return ce;
 }
diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.c b/drivers/gpu/drm/i915/gt/intel_gtt.c
index 2a72cce..34a68da 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.c
@@ -240,6 +240,7 @@ void i915_address_space_init(struct i915_address_space *vm, int subclass)
 	 */
 	mutex_init(&vm->mutex);
 	lockdep_set_subclass(&vm->mutex, subclass);
+	dept_mutex_reinit(&vm->mutex.dmap, NULL, subclass, NULL);
 	i915_gem_shrinker_taints_mutex(vm->i915, &vm->mutex);
 
 	GEM_BUG_ON(!vm->total);
diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index 49a6972..44eb691 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -279,7 +279,8 @@ void __i915_active_init(struct i915_active *ref,
 			int (*active)(struct i915_active *ref),
 			void (*retire)(struct i915_active *ref),
 			struct lock_class_key *mkey,
-			struct lock_class_key *wkey)
+			struct lock_class_key *wkey,
+			struct dept_key *mdkey)
 {
 	unsigned long bits;
 
@@ -297,10 +298,7 @@ void __i915_active_init(struct i915_active *ref,
 
 	init_llist_head(&ref->preallocated_barriers);
 	atomic_set(&ref->count, 0);
-	/*
-	 * TODO: Initialize the mutex with a valid dept_key.
-	 */
-	__mutex_init(&ref->mutex, "i915_active", mkey, NULL);
+	__mutex_init(&ref->mutex, "i915_active", mkey, mdkey);
 	__i915_active_fence_init(&ref->excl, NULL, excl_retire);
 	INIT_WORK(&ref->work, active_work);
 #if IS_ENABLED(CONFIG_LOCKDEP)
diff --git a/drivers/gpu/drm/i915/i915_active.h b/drivers/gpu/drm/i915/i915_active.h
index cf40581..97aa09b 100644
--- a/drivers/gpu/drm/i915/i915_active.h
+++ b/drivers/gpu/drm/i915/i915_active.h
@@ -153,14 +153,16 @@ void __i915_active_init(struct i915_active *ref,
 			int (*active)(struct i915_active *ref),
 			void (*retire)(struct i915_active *ref),
 			struct lock_class_key *mkey,
-			struct lock_class_key *wkey);
+			struct lock_class_key *wkey,
+			struct dept_key *mdkey);
 
 /* Specialise each class of i915_active to avoid impossible lockdep cycles. */
 #define i915_active_init(ref, active, retire) do {		\
 	static struct lock_class_key __mkey;				\
 	static struct lock_class_key __wkey;				\
+	static struct dept_key __mdkey;					\
 									\
-	__i915_active_init(ref, active, retire, &__mkey, &__wkey);	\
+	__i915_active_init(ref, active, retire, &__mkey, &__wkey, &__mdkey); \
 } while (0)
 
 int i915_active_ref(struct i915_active *ref,
diff --git a/drivers/gpu/drm/nouveau/nvkm/core/subdev.c b/drivers/gpu/drm/nouveau/nvkm/core/subdev.c
index f968d62..180e063 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/subdev.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/subdev.c
@@ -27,6 +27,7 @@
 #include <subdev/mc.h>
 
 static struct lock_class_key nvkm_subdev_lock_class[NVKM_SUBDEV_NR];
+static struct dept_key nvkm_subdev_dept_keys[NVKM_SUBDEV_NR];
 
 const char *
 nvkm_subdev_name[NVKM_SUBDEV_NR] = {
@@ -218,10 +219,8 @@
 	subdev->device = device;
 	subdev->index = index;
 
-	/*
-	 * TODO: Initialize the mutex with a valid dept_key.
-	 */
-	__mutex_init(&subdev->mutex, name, &nvkm_subdev_lock_class[index], NULL);
+	__mutex_init(&subdev->mutex, name, &nvkm_subdev_lock_class[index],
+			&nvkm_subdev_dept_keys[index]);
 	subdev->debug = nvkm_dbgopt(device->dbgopt, name);
 }
 
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 505c562..b274b27 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -865,6 +865,8 @@ static struct mousedev *mousedev_create(struct input_dev *dev,
 	mutex_init(&mousedev->mutex);
 	lockdep_set_subclass(&mousedev->mutex,
 			     mixdev ? SINGLE_DEPTH_NESTING : 0);
+	dept_mutex_reinit(&mousedev->mutex.dmap, NULL,
+			  mixdev ? SINGLE_DEPTH_NESTING : 0, NULL);
 	init_waitqueue_head(&mousedev->wait);
 
 	if (mixdev) {
diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 8a16e41..3001ccb 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -377,6 +377,7 @@ void ps2_init(struct ps2dev *ps2dev, struct serio *serio)
 {
 	mutex_init(&ps2dev->cmd_mutex);
 	lockdep_set_subclass(&ps2dev->cmd_mutex, serio->depth);
+	dept_mutex_reinit(&ps2dev->cmd_mutex.dmap, NULL, serio->depth, NULL);
 	init_waitqueue_head(&ps2dev->wait);
 	ps2dev->serio = serio;
 }
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 29f4910..0a371bdd 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -517,6 +517,7 @@ static void serio_init_port(struct serio *serio)
 	} else
 		serio->depth = 0;
 	lockdep_set_subclass(&serio->lock, serio->depth);
+	dept_spin_reinit(&serio->lock.dmap, NULL, serio->depth, NULL);
 }
 
 /*
diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
index 28b8581..4bd402d 100644
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -30,6 +30,8 @@ static int mac_hid_create_emumouse(void)
 {
 	static struct lock_class_key mac_hid_emumouse_dev_event_class;
 	static struct lock_class_key mac_hid_emumouse_dev_mutex_class;
+	static struct dept_key mac_hid_emumouse_dev_event_dkey;
+	static struct dept_key mac_hid_emumouse_dev_mutex_dkey;
 	int err;
 
 	mac_hid_emumouse_dev = input_allocate_device();
@@ -40,6 +42,10 @@ static int mac_hid_create_emumouse(void)
 			  &mac_hid_emumouse_dev_event_class);
 	lockdep_set_class(&mac_hid_emumouse_dev->mutex,
 			  &mac_hid_emumouse_dev_mutex_class);
+	dept_spin_reinit(&mac_hid_emumouse_dev->event_lock.dmap,
+			  &mac_hid_emumouse_dev_event_dkey, -1, NULL);
+	dept_mutex_reinit(&mac_hid_emumouse_dev->mutex.dmap,
+			  &mac_hid_emumouse_dev_mutex_dkey, -1, NULL);
 
 	mac_hid_emumouse_dev->name = "Macintosh mouse button emulation";
 	mac_hid_emumouse_dev->id.bustype = BUS_ADB;
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 3d8bd06..6917441b 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -573,6 +573,7 @@ static struct btree *mca_bucket_alloc(struct cache_set *c,
 	lockdep_set_novalidate_class(&b->lock);
 	mutex_init(&b->write_lock);
 	lockdep_set_novalidate_class(&b->write_lock);
+	dept_mutex_nocheck(&b->write_lock.dmap);
 	INIT_LIST_HEAD(&b->list);
 	INIT_DELAYED_WORK(&b->work, btree_node_write_work);
 	b->c = c;
diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 45a2403..ff2079c 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -2258,11 +2258,14 @@ static inline int handler_set_err(struct v4l2_ctrl_handler *hdl, int err)
 /* Initialize the handler */
 int v4l2_ctrl_handler_init_class(struct v4l2_ctrl_handler *hdl,
 				 unsigned nr_of_controls_hint,
-				 struct lock_class_key *key, const char *name)
+				 struct lock_class_key *key,
+				 struct dept_eky *dkey,
+				 const char *name)
 {
 	mutex_init(&hdl->_lock);
 	hdl->lock = &hdl->_lock;
 	lockdep_set_class_and_name(hdl->lock, key, name);
+	dept_mutex_reinit(&hdl->lock->dmap, dkey, -1, name);
 	INIT_LIST_HEAD(&hdl->ctrls);
 	INIT_LIST_HEAD(&hdl->ctrl_refs);
 	INIT_LIST_HEAD(&hdl->requests);
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c
index 94994a9..2562380 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c
@@ -1140,6 +1140,7 @@ int nfp_xpb_writelm(struct nfp_cpp *cpp, u32 xpb_tgt,
 
 /* Lockdep markers */
 static struct lock_class_key nfp_cpp_resource_lock_key;
+static struct dept_key nfp_cpp_resource_lock_dkey;
 
 static void nfp_cpp_dev_release(struct device *dev)
 {
@@ -1192,6 +1193,7 @@ struct nfp_cpp *
 	rwlock_init(&cpp->resource_lock);
 	init_waitqueue_head(&cpp->waitq);
 	lockdep_set_class(&cpp->resource_lock, &nfp_cpp_resource_lock_key);
+	dept_rw_reinit(&cpp->resource_lock.dmap, &nfp_cpp_resource_lock_dkey, -1, NULL);
 	INIT_LIST_HEAD(&cpp->resource_list);
 	INIT_LIST_HEAD(&cpp->area_cache_list);
 	mutex_init(&cpp->area_cache_mutex);
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 0292404..8135a9e 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1646,6 +1646,7 @@ static int team_init(struct net_device *dev)
 	netif_carrier_off(dev);
 
 	lockdep_register_key(&team->team_lock_key);
+	dept_key_init(&team->team_dkey);
 	/*
 	 * TODO: Initialize the mutex with a valid dept_key.
 	 */
@@ -1682,6 +1683,7 @@ static void team_uninit(struct net_device *dev)
 	mutex_unlock(&team->lock);
 	netdev_change_features(dev);
 	lockdep_unregister_key(&team->team_lock_key);
+	dept_key_destroy(&team->team_dkey);
 }
 
 static void team_destructor(struct net_device *dev)
@@ -1992,6 +1994,9 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 		lockdep_unregister_key(&team->team_lock_key);
 		lockdep_register_key(&team->team_lock_key);
 		lockdep_set_class(&team->lock, &team->team_lock_key);
+		dept_key_destroy(&team->team_dkey);
+		dept_key_init(&team->team_dkey);
+		dept_mutex_reinit(&team->lock, &team->team_dkey, -1, NULL);
 	}
 	netdev_change_features(dev);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index eb396c0..49ad297 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -608,8 +608,11 @@ int iwl_pcie_txq_init(struct iwl_trans *trans, struct iwl_txq *txq,
 
 	if (cmd_queue) {
 		static struct lock_class_key iwl_pcie_cmd_queue_lock_class;
+		static struct dept_key iwl_pcie_cmd_queue_dkey;
 
 		lockdep_set_class(&txq->lock, &iwl_pcie_cmd_queue_lock_class);
+		dept_spin_reinit(&txq->lock.dmap, &iwl_pcie_cmd_queue_dkey,
+				 -1, NULL);
 	}
 
 	__skb_queue_head_init(&txq->overflow_q);
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 63a41b1..10aeb2c 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -943,6 +943,7 @@ struct raw3270 __init *raw3270_setup_console(void)
 		view->ascebc = rp->ascebc;
 		spin_lock_init(&view->lock);
 		lockdep_set_subclass(&view->lock, subclass);
+		dept_spin_reinit(&view->lock.dmap, NULL, subclass, NULL);
 		list_add(&view->list, &rp->view_list);
 		rc = 0;
 		spin_unlock_irqrestore(get_ccwdev_lock(rp->cdev), flags);
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 6d716db..cd88dbf 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -574,6 +574,7 @@ void __init init_cio_interrupts(void)
 #ifdef CONFIG_CCW_CONSOLE
 static struct subchannel *console_sch;
 static struct lock_class_key console_sch_key;
+static struct dept_key console_sch_dkey;
 
 /*
  * Use cio_tsch to update the subchannel status and call the interrupt handler
@@ -664,6 +665,7 @@ struct subchannel *cio_probe_console(void)
 		return sch;
 
 	lockdep_set_class(sch->lock, &console_sch_key);
+	dept_spin_reinit(&sch->lock->dmap, &console_sch_dkey, -1, NULL);
 	isc_register(CONSOLE_ISC);
 	sch->config.isc = CONSOLE_ISC;
 	sch->config.intparm = (u32)(addr_t)sch;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 6a73982..f753d93 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -63,6 +63,7 @@ struct qeth_dbf_info qeth_dbf[QETH_DBF_INFOS] = {
 static struct device *qeth_core_root_dev;
 static struct dentry *qeth_debugfs_root;
 static struct lock_class_key qdio_out_skb_queue_key;
+static struct dept_key qdio_out_skb_queue_dkey;
 
 static void qeth_issue_next_read_cb(struct qeth_card *card,
 				    struct qeth_cmd_buffer *iob,
@@ -2632,6 +2633,8 @@ static int qeth_init_qdio_out_buf(struct qeth_qdio_out_q *q, int bidx)
 	newbuf->buffer = q->qdio_bufs[bidx];
 	skb_queue_head_init(&newbuf->skb_list);
 	lockdep_set_class(&newbuf->skb_list.lock, &qdio_out_skb_queue_key);
+	dept_spin_reinit(&newbuf->skb_list.lock.dmap,
+			 &qdio_out_skb_queue_dkey, -1, NULL);
 	newbuf->q = q;
 	newbuf->next_pending = q->bufs[bidx];
 	atomic_set(&newbuf->state, QETH_QDIO_BUF_EMPTY);
diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 7d16fe4..f4c4bd5 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -73,6 +73,7 @@ static int ifx_modem_reboot_callback(struct notifier_block *nfb,
 static struct tty_driver *tty_drv;
 static struct ifx_spi_device *saved_ifx_dev;
 static struct lock_class_key ifx_spi_key;
+static struct dept_key ifx_spi_dkey;
 
 static struct notifier_block ifx_modem_reboot_notifier_block = {
 	.notifier_call = ifx_modem_reboot_callback,
@@ -819,6 +820,7 @@ static int ifx_spi_create_port(struct ifx_spi_device *ifx_dev)
 	spin_lock_init(&ifx_dev->fifo_lock);
 	lockdep_set_class_and_subclass(&ifx_dev->fifo_lock,
 		&ifx_spi_key, 0);
+	dept_spin_reinit(&ifx_dev->fifo_lock.dmap, &ifx_spi_dkey, 0, NULL);
 
 	if (kfifo_alloc(&ifx_dev->tx_fifo, IFX_SPI_FIFO_SIZE, GFP_KERNEL)) {
 		ret = -ENOMEM;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 124524e..d8fa640 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -39,6 +39,7 @@
  *          want only one lock-class:
  */
 static struct lock_class_key port_lock_key;
+static struct dept_key port_lock_dkey;
 
 #define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
 
@@ -1920,6 +1921,7 @@ static void uart_port_spin_lock_init(struct uart_port *port)
 {
 	spin_lock_init(&port->lock);
 	lockdep_set_class(&port->lock, &port_lock_key);
+	dept_spin_reinit(&port->lock.dmap, &port_lock_dkey, -1, NULL);
 }
 
 #if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index ec145a5..65f243b 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -601,6 +601,7 @@ int tty_buffer_set_limit(struct tty_port *port, int limit)
 void tty_buffer_set_lock_subclass(struct tty_port *port)
 {
 	lockdep_set_subclass(&port->buf.lock, TTY_LOCK_SLAVE);
+	dept_mutex_reinit(&port->buf.lock.dmap, NULL, TTY_LOCK_SLAVE, NULL);
 }
 
 bool tty_buffer_restart_work(struct tty_port *port)
diff --git a/drivers/tty/tty_mutex.c b/drivers/tty/tty_mutex.c
index 2640635..b3cde7a 100644
--- a/drivers/tty/tty_mutex.c
+++ b/drivers/tty/tty_mutex.c
@@ -57,4 +57,5 @@ void tty_unlock_slave(struct tty_struct *tty)
 void tty_set_lock_subclass(struct tty_struct *tty)
 {
 	lockdep_set_subclass(&tty->legacy_mutex, TTY_LOCK_SLAVE);
+	dept_mutex_reinit(&tty->legacy_mutex.dmap, NULL, TTY_LOCK_SLAVE, NULL);
 }
diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index 94a6472..7ff0a53 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -137,6 +137,7 @@
 #ifdef CONFIG_LOCKDEP
 
 static struct lock_class_key us_interface_key[USB_MAXINTERFACES];
+static struct dept_key us_interface_dkey[USB_MAXINTERFACES];
 
 static void us_set_lock_class(struct mutex *mutex,
 		struct usb_interface *intf)
@@ -153,6 +154,7 @@ static void us_set_lock_class(struct mutex *mutex,
 	BUG_ON(i == config->desc.bNumInterfaces);
 
 	lockdep_set_class(mutex, &us_interface_key[i]);
+	dept_mutex_reinit(&mutex->dmap, &us_interface_dkey[i], -1, NULL);
 }
 
 #else
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9f72b09..dc8c583 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -156,6 +156,7 @@ struct async_submit_bio {
 	const char		*name_stem;	/* lock name stem */
 	char			names[BTRFS_MAX_LEVEL + 1][20];
 	struct lock_class_key	keys[BTRFS_MAX_LEVEL + 1];
+	struct dept_key		dkeys[BTRFS_MAX_LEVEL + 1];
 } btrfs_lockdep_keysets[] = {
 	{ .id = BTRFS_ROOT_TREE_OBJECTID,	.name_stem = "root"	},
 	{ .id = BTRFS_EXTENT_TREE_OBJECTID,	.name_stem = "extent"	},
@@ -200,6 +201,8 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,
 
 	lockdep_set_class_and_name(&eb->lock,
 				   &ks->keys[level], ks->names[level]);
+	dept_rw_reinit(&eb->lock.dmap,
+		       &ks->dkeys[level], -1, ks->names[level]);
 }
 
 #endif
diff --git a/fs/dcache.c b/fs/dcache.c
index 70fdcdc..9f8976b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1343,6 +1343,7 @@ static void d_walk(struct dentry *parent, void *data,
 			spin_release(&dentry->d_lock.dep_map, _RET_IP_);
 			this_parent = dentry;
 			spin_acquire(&this_parent->d_lock.dep_map, 0, 1, _RET_IP_);
+			dept_spin_switch_nested(&this_parent->d_lock.dmap, 0, _RET_IP_);
 			goto repeat;
 		}
 		spin_unlock(&dentry->d_lock);
diff --git a/fs/inode.c b/fs/inode.c
index 72c4c34..893a55b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -172,6 +172,12 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 		goto out;
 	spin_lock_init(&inode->i_lock);
 	lockdep_set_class(&inode->i_lock, &sb->s_type->i_lock_key);
+	/*
+	 * TODO: Should re-initialize the map with a valid dept_key.
+	 * Also needs dept_key_inti() before using it, dept_key_destroy()
+	 * before freeing it.
+	 */
+	dept_spin_nocheck(&inode->i_lock.dmap);
 
 	init_rwsem(&inode->i_rwsem);
 	lockdep_set_class(&inode->i_rwsem, &sb->s_type->i_mutex_key);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 9bb9f09..88236e0 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -398,6 +398,7 @@ void __ntfs_init_inode(struct super_block *sb, ntfs_inode *ni)
  * a separate class for nested inode's mrec_lock's:
  */
 static struct lock_class_key extent_inode_mrec_lock_key;
+static struct dept_key extent_inode_mrec_lock_dkey;
 
 inline ntfs_inode *ntfs_new_extent_inode(struct super_block *sb,
 		unsigned long mft_no)
@@ -408,6 +409,8 @@ inline ntfs_inode *ntfs_new_extent_inode(struct super_block *sb,
 	if (likely(ni != NULL)) {
 		__ntfs_init_inode(sb, ni);
 		lockdep_set_class(&ni->mrec_lock, &extent_inode_mrec_lock_key);
+		dept_mutex_reinit(&ni->mrec_lock.dmap,
+				  &extent_inode_mrec_lock_dkey, -1, NULL);
 		ni->mft_no = mft_no;
 		ni->type = AT_UNUSED;
 		ni->name = NULL;
@@ -1711,6 +1714,7 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
  * map_mft functions.
  */
 static struct lock_class_key mft_ni_runlist_lock_key, mft_ni_mrec_lock_key;
+static struct dept_key mft_ni_mrec_lock_dkey;
 
 /**
  * ntfs_read_inode_mount - special read_inode for mount time use only
@@ -2145,6 +2149,7 @@ int ntfs_read_inode_mount(struct inode *vi)
 	 */
 	lockdep_set_class(&ni->runlist.lock, &mft_ni_runlist_lock_key);
 	lockdep_set_class(&ni->mrec_lock, &mft_ni_mrec_lock_key);
+	dept_mutex_reinit(&ni->mrec_lock.dmap, &mft_ni_mrec_lock_dkey, -1, NULL);
 
 	return 0;
 
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 7dc3bc6..66f98d7 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1745,6 +1745,8 @@ static bool load_and_init_upcase(ntfs_volume *vol)
 static struct lock_class_key
 	lcnbmp_runlist_lock_key, lcnbmp_mrec_lock_key,
 	mftbmp_runlist_lock_key, mftbmp_mrec_lock_key;
+static struct dept_key
+	lcnbmp_mrec_lock_dkey, mftbmp_mrec_lock_dkey;
 
 /**
  * load_system_files - open the system files using normal functions
@@ -1806,6 +1808,8 @@ static bool load_system_files(ntfs_volume *vol)
 			   &mftbmp_runlist_lock_key);
 	lockdep_set_class(&NTFS_I(vol->mftbmp_ino)->mrec_lock,
 			   &mftbmp_mrec_lock_key);
+	dept_mutex_reinit(&NTFS_I(vol->mftbmp_ino)->mrec_lock.dmap,
+			   &mftbmp_mrec_lock_dkey, -1, NULL);
 	/* Read upcase table and setup @vol->upcase and @vol->upcase_len. */
 	if (!load_and_init_upcase(vol))
 		goto iput_mftbmp_err_out;
@@ -1832,6 +1836,8 @@ static bool load_system_files(ntfs_volume *vol)
 			   &lcnbmp_runlist_lock_key);
 	lockdep_set_class(&NTFS_I(vol->lcnbmp_ino)->mrec_lock,
 			   &lcnbmp_mrec_lock_key);
+	dept_mutex_reinit(&NTFS_I(vol->lcnbmp_ino)->mrec_lock.dmap,
+			   &lcnbmp_mrec_lock_dkey, -1, NULL);
 
 	NInoSetSparseDisabled(NTFS_I(vol->lcnbmp_ino));
 	if ((vol->nr_clusters + 7) >> 3 > i_size_read(vol->lcnbmp_ino)) {
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 8be6cd2..6ce92d5 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -562,6 +562,7 @@ static inline void ovl_lockdep_annotate_inode_mutex_key(struct inode *inode)
 	static struct lock_class_key ovl_i_mutex_key[OVL_MAX_NESTING];
 	static struct lock_class_key ovl_i_mutex_dir_key[OVL_MAX_NESTING];
 	static struct lock_class_key ovl_i_lock_key[OVL_MAX_NESTING];
+	static struct dept_key ovl_i_lock_dkey[OVL_MAX_NESTING];
 
 	int depth = inode->i_sb->s_stack_depth - 1;
 
@@ -574,6 +575,8 @@ static inline void ovl_lockdep_annotate_inode_mutex_key(struct inode *inode)
 		lockdep_set_class(&inode->i_rwsem, &ovl_i_mutex_key[depth]);
 
 	lockdep_set_class(&OVL_I(inode)->lock, &ovl_i_lock_key[depth]);
+	dept_mutex_reinit(&OVL_I(inode)->lock.dmap, &ovl_i_lock_dkey[depth],
+			  -1, NULL);
 #endif
 }
 
diff --git a/fs/super.c b/fs/super.c
index 904459b..6ad5883 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -254,6 +254,12 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	atomic_set(&s->s_active, 1);
 	mutex_init(&s->s_vfs_rename_mutex);
 	lockdep_set_class(&s->s_vfs_rename_mutex, &type->s_vfs_rename_key);
+	/*
+	 * TODO: Should re-initialize the map with a valid dept_key.
+	 * Also needs dept_key_init() before using it, dept_key_destroy()
+	 * before freeing it.
+	 */
+	dept_mutex_nocheck(&s->s_vfs_rename_mutex.dmap);
 	init_rwsem(&s->s_dquot.dqio_sem);
 	s->s_maxbytes = MAX_NON_LFS;
 	s->s_op = &default_op;
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index bcd73b9..7370782c 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -43,6 +43,8 @@
 
 static struct lock_class_key xfs_dquot_group_class;
 static struct lock_class_key xfs_dquot_project_class;
+static struct dept_key xfs_dquot_group_dkey;
+static struct dept_key xfs_dquot_project_dkey;
 
 /*
  * This is called to free all the memory associated with a dquot
@@ -461,9 +463,11 @@
 		break;
 	case XFS_DQTYPE_GROUP:
 		lockdep_set_class(&dqp->q_qlock, &xfs_dquot_group_class);
+		dept_mutex_reinit(&dqp->q_qlock.dmap, &xfs_dquot_group_dkey, -1, NULL);
 		break;
 	case XFS_DQTYPE_PROJ:
 		lockdep_set_class(&dqp->q_qlock, &xfs_dquot_project_class);
+		dept_mutex_reinit(&dqp->q_qlock.dmap, &xfs_dquot_project_dkey, -1, NULL);
 		break;
 	default:
 		ASSERT(0);
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index e8d470c..cbe7e08 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -85,15 +85,17 @@ struct class_dev_iter {
 extern struct kobject *sysfs_dev_block_kobj;
 extern struct kobject *sysfs_dev_char_kobj;
 extern int __must_check __class_register(struct class *class,
-					 struct lock_class_key *key);
+					 struct lock_class_key *key,
+					 struct dept_key *dkey);
 extern void class_unregister(struct class *class);
 
 /* This is a #define to keep the compiler from merging different
  * instances of the __key variable */
-#define class_register(class)			\
-({						\
-	static struct lock_class_key __key;	\
-	__class_register(class, &__key);	\
+#define class_register(class)				\
+({							\
+	static struct lock_class_key __key;		\
+	static struct dept_key __dkey;			\
+	__class_register(class, &__key, &__dkey);	\
 })
 
 struct class_compat;
@@ -251,15 +253,17 @@ struct class_interface {
 
 extern struct class * __must_check __class_create(struct module *owner,
 						  const char *name,
-						  struct lock_class_key *key);
+						  struct lock_class_key *key,
+						  struct dept_key *dkey);
 extern void class_destroy(struct class *cls);
 
 /* This is a #define to keep the compiler from merging different
  * instances of the __key variable */
-#define class_create(owner, name)		\
-({						\
-	static struct lock_class_key __key;	\
-	__class_create(owner, name, &__key);	\
+#define class_create(owner, name)			\
+({							\
+	static struct lock_class_key __key;		\
+	static struct dept_key __dkey;			\
+	__class_create(owner, name, &__key, &__dkey);	\
 })
 
 
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index add6079..9fc27fe 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -221,6 +221,7 @@ struct team {
 		struct delayed_work dw;
 	} mcast_rejoin;
 	struct lock_class_key team_lock_key;
+	struct dept_key team_dkey;
 	long mode_priv[TEAM_MODE_PRIV_LONGS];
 };
 
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 5745491..57b13d0 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -261,6 +261,12 @@ static inline bool irq_is_percpu_devid(unsigned int irq)
 	if (desc) {
 		lockdep_set_class(&desc->lock, lock_class);
 		lockdep_set_class(&desc->request_mutex, request_class);
+		/*
+		 * TODO: Should re-initialize the map with a valid
+		 * dept_key. Also need dept_key_init() before using it.
+		 */
+		dept_spin_nocheck(&desc->lock.dmap);
+		dept_mutex_nocheck(&desc->request_mutex.dmap);
 	}
 }
 
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 65b81e0..81f4ad5 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -149,12 +149,14 @@ struct kthread_delayed_work {
 #endif
 
 extern void __kthread_init_worker(struct kthread_worker *worker,
-			const char *name, struct lock_class_key *key);
+			const char *name, struct lock_class_key *key,
+			struct dept_key *dkey);
 
 #define kthread_init_worker(worker)					\
 	do {								\
 		static struct lock_class_key __key;			\
-		__kthread_init_worker((worker), "("#worker")->lock", &__key); \
+		static struct dept_key __dkey;				\
+		__kthread_init_worker((worker), "("#worker")->lock", &__key, &__dkey); \
 	} while (0)
 
 #define kthread_init_work(work, fn)					\
diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 01861ee..32a1dab 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -29,13 +29,15 @@ struct percpu_counter {
 extern int percpu_counter_batch;
 
 int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
-			  struct lock_class_key *key);
+			  struct lock_class_key *key,
+			  struct dept_key *dkey);
 
 #define percpu_counter_init(fbc, value, gfp)				\
 	({								\
 		static struct lock_class_key __key;			\
+		static struct dept_key __dkey;			\
 									\
-		__percpu_counter_init(fbc, value, gfp, &__key);		\
+		__percpu_counter_init(fbc, value, gfp, &__key, &__dkey); \
 	})
 
 void percpu_counter_destroy(struct percpu_counter *fbc);
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 04a18e0..2936a55 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1885,10 +1885,12 @@ static inline void skb_queue_head_init(struct sk_buff_head *list)
 }
 
 static inline void skb_queue_head_init_class(struct sk_buff_head *list,
-		struct lock_class_key *class)
+		struct lock_class_key *class,
+		struct dept_key *dkey)
 {
 	skb_queue_head_init(list);
 	lockdep_set_class(&list->lock, class);
+	dept_spin_reinit(&list->lock.dmap, dkey, -1, NULL);
 }
 
 /*
diff --git a/include/linux/swait.h b/include/linux/swait.h
index 6a8c22b..84e21ec 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -67,12 +67,14 @@ struct swait_queue {
 	struct swait_queue_head name = __SWAIT_QUEUE_HEAD_INITIALIZER(name)
 
 extern void __init_swait_queue_head(struct swait_queue_head *q, const char *name,
-				    struct lock_class_key *key);
+				    struct lock_class_key *key,
+				    struct dept_key *dkey);
 
 #define init_swait_queue_head(q)				\
 	do {							\
 		static struct lock_class_key __key;		\
-		__init_swait_queue_head((q), #q, &__key);	\
+		static struct dept_key __dkey;			\
+		__init_swait_queue_head((q), #q, &__key, &__dkey); \
 	} while (0)
 
 #ifdef CONFIG_LOCKDEP
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index f40e2cb..fc37ee0 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -465,6 +465,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
  *		buckets are allocated, so there are more slow list lookups).
  *		It will always work, though.
  * @key:	Used by the lock validator if CONFIG_LOCKDEP is set.
+ * @dkey:	Used by the dependency tracker if CONFIG_DEPT is set.
  * @name:	Used by the lock validator if CONFIG_LOCKDEP is set.
  *
  * .. attention::
@@ -477,7 +478,8 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
  */
 int v4l2_ctrl_handler_init_class(struct v4l2_ctrl_handler *hdl,
 				 unsigned int nr_of_controls_hint,
-				 struct lock_class_key *key, const char *name);
+				 struct lock_class_key *key,
+				 struct dept_key *dkey, const char *name);
 
 #ifdef CONFIG_LOCKDEP
 
@@ -504,8 +506,10 @@ int v4l2_ctrl_handler_init_class(struct v4l2_ctrl_handler *hdl,
 (									\
 	({								\
 		static struct lock_class_key _key;			\
+		static struct dept_key _dkey;			\
 		v4l2_ctrl_handler_init_class(hdl, nr_of_controls_hint,	\
 					&_key,				\
+					&_dkey,				\
 					KBUILD_BASENAME ":"		\
 					__stringify(__LINE__) ":"	\
 					"(" #hdl ")->_lock");		\
@@ -513,7 +517,7 @@ int v4l2_ctrl_handler_init_class(struct v4l2_ctrl_handler *hdl,
 )
 #else
 #define v4l2_ctrl_handler_init(hdl, nr_of_controls_hint)		\
-	v4l2_ctrl_handler_init_class(hdl, nr_of_controls_hint, NULL, NULL)
+	v4l2_ctrl_handler_init_class(hdl, nr_of_controls_hint, NULL, NULL, NULL)
 #endif
 
 /**
diff --git a/include/net/sock.h b/include/net/sock.h
index 064637d..3d90488 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1565,6 +1565,7 @@ static inline void sock_release_ownership(struct sock *sk)
 			sizeof((sk)->sk_lock));				\
 	lockdep_set_class_and_name(&(sk)->sk_lock.slock,		\
 				(skey), (sname));				\
+	dept_spin_nocheck(&(sk)->sk_lock.slock.dmap);			\
 	lockdep_init_map(&(sk)->sk_lock.dep_map, (name), (key), 0);	\
 } while (0)
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e8bf9220..10556cc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10703,6 +10703,8 @@ static int pmu_dev_alloc(struct pmu *pmu)
 
 static struct lock_class_key cpuctx_mutex;
 static struct lock_class_key cpuctx_lock;
+static struct dept_key cpuctx_mutex_dkey;
+static struct dept_key cpuctx_spin_dkey;
 
 int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 {
@@ -10771,6 +10773,8 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		__perf_event_init_context(&cpuctx->ctx);
 		lockdep_set_class(&cpuctx->ctx.mutex, &cpuctx_mutex);
 		lockdep_set_class(&cpuctx->ctx.lock, &cpuctx_lock);
+		dept_mutex_reinit(&cpuctx->ctx.mutex.dmap, &cpuctx_mutex_dkey, -1, NULL);
+		dept_spin_reinit(&cpuctx->ctx.lock.dmap, &cpuctx_spin_dkey, -1, NULL);
 		cpuctx->ctx.pmu = pmu;
 		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 1a77236..27d98bf 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -23,6 +23,7 @@
  * lockdep: we want to handle all irq_desc locks as a single lock-class:
  */
 static struct lock_class_key irq_desc_lock_class;
+static struct dept_key irq_desc_dkey;
 
 #if defined(CONFIG_SMP)
 static int __init irq_affinity_setup(char *str)
@@ -403,6 +404,7 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 
 	raw_spin_lock_init(&desc->lock);
 	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
+	dept_spin_reinit(&desc->lock.dmap, &irq_desc_dkey, -1, NULL);
 	mutex_init(&desc->request_mutex);
 	init_rcu_head(&desc->rcu);
 
@@ -572,6 +574,7 @@ int __init early_irq_init(void)
 		alloc_masks(&desc[i], node);
 		raw_spin_lock_init(&desc[i].lock);
 		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
+		dept_spin_reinit(&desc[i].lock.dmap, &irq_desc_dkey, -1, NULL);
 		mutex_init(&desc[i].request_mutex);
 		desc_set_defaults(i, &desc[i], node, NULL, NULL);
 	}
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3edaa38..212245e 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -642,11 +642,13 @@ int kthreadd(void *unused)
 
 void __kthread_init_worker(struct kthread_worker *worker,
 				const char *name,
-				struct lock_class_key *key)
+				struct lock_class_key *key,
+				struct dept_key *dkey)
 {
 	memset(worker, 0, sizeof(struct kthread_worker));
 	raw_spin_lock_init(&worker->lock);
 	lockdep_set_class_and_name(&worker->lock, key, name);
+	dept_spin_reinit(&worker->lock.dmap, dkey, -1, name);
 	INIT_LIST_HEAD(&worker->work_list);
 	INIT_LIST_HEAD(&worker->delayed_work_list);
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f78ee75..e6a6c31 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4211,6 +4211,8 @@ static void __init rcu_init_one(void)
 	static const char * const fqs[] = RCU_FQS_NAME_INIT;
 	static struct lock_class_key rcu_node_class[RCU_NUM_LVLS];
 	static struct lock_class_key rcu_fqs_class[RCU_NUM_LVLS];
+	static struct dept_key rcu_node_dkey[RCU_NUM_LVLS];
+	static struct dept_key rcu_fqs_dkey[RCU_NUM_LVLS];
 
 	int levelspread[RCU_NUM_LVLS];		/* kids/node in each level. */
 	int cpustride = 1;
@@ -4240,9 +4242,13 @@ static void __init rcu_init_one(void)
 			raw_spin_lock_init(&ACCESS_PRIVATE(rnp, lock));
 			lockdep_set_class_and_name(&ACCESS_PRIVATE(rnp, lock),
 						   &rcu_node_class[i], buf[i]);
+			dept_spin_reinit(&ACCESS_PRIVATE(rnp, lock).dmap,
+					 &rcu_node_dkey[i], -1, buf[i]);
 			raw_spin_lock_init(&rnp->fqslock);
 			lockdep_set_class_and_name(&rnp->fqslock,
 						   &rcu_fqs_class[i], fqs[i]);
+			dept_spin_reinit(&rnp->fqslock.dmap,
+					 &rcu_fqs_dkey[i], -1, fqs[i]);
 			rnp->gp_seq = rcu_state.gp_seq;
 			rnp->gp_seq_needed = rcu_state.gp_seq;
 			rnp->completedqs = rcu_state.gp_seq;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6..2d12d23 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2140,6 +2140,7 @@ static inline void double_unlock_balance(struct rq *this_rq, struct rq *busiest)
 {
 	raw_spin_unlock(&busiest->lock);
 	lock_set_subclass(&this_rq->lock.dep_map, 0, _RET_IP_);
+	dept_spin_switch_nested(&this_rq->lock.dmap, 0, _RET_IP_);
 }
 
 static inline void double_lock(spinlock_t *l1, spinlock_t *l2)
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index e1c655f..4b71484 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -5,10 +5,12 @@
 #include "sched.h"
 
 void __init_swait_queue_head(struct swait_queue_head *q, const char *name,
-			     struct lock_class_key *key)
+			     struct lock_class_key *key,
+			     struct dept_key *dkey)
 {
 	raw_spin_lock_init(&q->lock);
 	lockdep_set_class_and_name(&q->lock, key, name);
+	dept_spin_reinit(&q->lock.dmap, dkey, -1, name);
 	INIT_LIST_HEAD(&q->task_list);
 }
 EXPORT_SYMBOL(__init_swait_queue_head);
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 01f5d30..5964642 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -10,6 +10,10 @@ void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *name, st
 {
 	spin_lock_init(&wq_head->lock);
 	lockdep_set_class_and_name(&wq_head->lock, key, name);
+	/*
+	 * TODO: Should re-initialize the map with a valid dept_key.
+	 */
+	dept_spin_nocheck(&wq_head->lock.dmap);
 	INIT_LIST_HEAD(&wq_head->head);
 }
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 93ef0ab..ae1e647 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1533,6 +1533,10 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	cpu_buffer->buffer = buffer;
 	raw_spin_lock_init(&cpu_buffer->reader_lock);
 	lockdep_set_class(&cpu_buffer->reader_lock, buffer->reader_lock_key);
+	/*
+	 * TODO: Shoule initialize the map with a valid dept_key.
+	 */
+	dept_spin_nocheck(&cpu_buffer->reader_lock.dmap);
 	cpu_buffer->lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 	INIT_WORK(&cpu_buffer->update_pages_work, update_pages_handler);
 	init_completion(&cpu_buffer->update_done);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c41c3c1..710092e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3627,6 +3627,7 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 		goto fail;
 
 	lockdep_set_subclass(&pool->lock, 1);	/* see put_pwq() */
+	dept_spin_reinit(&pool->lock.dmap, NULL, 1, NULL);
 	copy_workqueue_attrs(pool->attrs, attrs);
 	pool->node = target_node;
 
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 34f3b85..bc88d1e 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -154,13 +154,14 @@ static void init_shared_classes(void)
 {
 #ifdef CONFIG_RT_MUTEXES
 	static struct lock_class_key rt_X, rt_Y, rt_Z;
-
-	__rt_mutex_init(&rtmutex_X1, __func__, &rt_X, NULL);
-	__rt_mutex_init(&rtmutex_X2, __func__, &rt_X, NULL);
-	__rt_mutex_init(&rtmutex_Y1, __func__, &rt_Y, NULL);
-	__rt_mutex_init(&rtmutex_Y2, __func__, &rt_Y, NULL);
-	__rt_mutex_init(&rtmutex_Z1, __func__, &rt_Z, NULL);
-	__rt_mutex_init(&rtmutex_Z2, __func__, &rt_Z, NULL);
+	static struct dept_key dept_rt_X, dept_rt_Y, dept_rt_Z;
+
+	__rt_mutex_init(&rtmutex_X1, __func__, &rt_X, &dept_rt_X);
+	__rt_mutex_init(&rtmutex_X2, __func__, &rt_X, &dept_rt_X);
+	__rt_mutex_init(&rtmutex_Y1, __func__, &rt_Y, &dept_rt_Y);
+	__rt_mutex_init(&rtmutex_Y2, __func__, &rt_Y, &dept_rt_Y);
+	__rt_mutex_init(&rtmutex_Z1, __func__, &rt_Z, &dept_rt_Z);
+	__rt_mutex_init(&rtmutex_Z2, __func__, &rt_Z, &dept_rt_Z);
 #endif
 
 	init_class_X(&lock_X1, &rwlock_X1, &mutex_X1, &rwsem_X1);
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index a2345de..d96a6eb 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -139,12 +139,14 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
 EXPORT_SYMBOL(__percpu_counter_sum);
 
 int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
-			  struct lock_class_key *key)
+			  struct lock_class_key *key,
+			  struct dept_key *dkey)
 {
 	unsigned long flags __maybe_unused;
 
 	raw_spin_lock_init(&fbc->lock);
 	lockdep_set_class(&fbc->lock, key);
+	dept_spin_reinit(&fbc->lock.dmap, dkey, -1, NULL);
 	fbc->count = amount;
 	fbc->counters = alloc_percpu_gfp(s32, gfp);
 	if (!fbc->counters)
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 5aa6e44..4c5142b 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -607,8 +607,14 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 
 	for_each_node(i) {
 		spin_lock_init(&lru->node[i].lock);
-		if (key)
+		if (key) {
 			lockdep_set_class(&lru->node[i].lock, key);
+			/*
+			 * TODO: Should re-initialize the map with a valid
+			 * dept_key.
+			 */
+			dept_spin_nocheck(&lru->node[i].lock.dmap);
+		}
 		init_one_lru(&lru->node[i].lru);
 	}
 
diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index 68638e0..48b4937 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -79,6 +79,11 @@ void batadv_hash_set_lock_class(struct batadv_hashtable *hash,
 {
 	u32 i;
 
-	for (i = 0; i < hash->size; i++)
+	for (i = 0; i < hash->size; i++) {
 		lockdep_set_class(&hash->list_locks[i], key);
+		/*
+		 * TODO: Should re-initialize the map with a valid dept_key.
+		 */
+		dept_spin_nocheck(&hash->list_locks[i].dmap);
+	}
 }
diff --git a/net/core/dev.c b/net/core/dev.c
index 4906b44..1d7db6b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -441,6 +441,8 @@ static void unlist_netdevice(struct net_device *dev)
 
 static struct lock_class_key netdev_xmit_lock_key[ARRAY_SIZE(netdev_lock_type)];
 static struct lock_class_key netdev_addr_lock_key[ARRAY_SIZE(netdev_lock_type)];
+static struct dept_key netdev_xmit_dkey[ARRAY_SIZE(netdev_lock_type)];
+static struct dept_key netdev_addr_dkey[ARRAY_SIZE(netdev_lock_type)];
 
 static inline unsigned short netdev_lock_pos(unsigned short dev_type)
 {
@@ -461,6 +463,8 @@ static inline void netdev_set_xmit_lockdep_class(spinlock_t *lock,
 	i = netdev_lock_pos(dev_type);
 	lockdep_set_class_and_name(lock, &netdev_xmit_lock_key[i],
 				   netdev_lock_name[i]);
+	dept_spin_reinit(&lock->dmap, &netdev_xmit_dkey[i], -1,
+			 netdev_lock_name[i]);
 }
 
 static inline void netdev_set_addr_lockdep_class(struct net_device *dev)
@@ -471,6 +475,9 @@ static inline void netdev_set_addr_lockdep_class(struct net_device *dev)
 	lockdep_set_class_and_name(&dev->addr_list_lock,
 				   &netdev_addr_lock_key[i],
 				   netdev_lock_name[i]);
+	dept_spin_reinit(&dev->addr_list_lock.dmap,
+			 &netdev_addr_dkey[i], -1,
+			 netdev_lock_name[i]);
 }
 #else
 static inline void netdev_set_xmit_lockdep_class(spinlock_t *lock,
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 8e39e28..e205027 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1669,6 +1669,7 @@ static void neigh_parms_destroy(struct neigh_parms *parms)
 }
 
 static struct lock_class_key neigh_table_proxy_queue_class;
+static struct dept_key neigh_table_proxy_queue_dkey;
 
 static struct neigh_table *neigh_tables[NEIGH_NR_TABLES] __read_mostly;
 
@@ -1715,7 +1716,8 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 			tbl->parms.reachable_time);
 	timer_setup(&tbl->proxy_timer, neigh_proxy_process, 0);
 	skb_queue_head_init_class(&tbl->proxy_queue,
-			&neigh_table_proxy_queue_class);
+			&neigh_table_proxy_queue_class,
+			&neigh_table_proxy_queue_dkey);
 
 	tbl->last_flush = now;
 	tbl->last_rand	= now + tbl->parms.reachable_time * 20;
diff --git a/net/core/sock.c b/net/core/sock.c
index 6c5c6b1..d5de709 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -264,6 +264,11 @@ bool sk_net_capable(const struct sock *sk, int cap)
 static struct lock_class_key af_wlock_keys[AF_MAX];
 static struct lock_class_key af_elock_keys[AF_MAX];
 static struct lock_class_key af_kern_callback_keys[AF_MAX];
+static struct dept_key af_callback_dkeys[AF_MAX];
+static struct dept_key af_rlock_dkeys[AF_MAX];
+static struct dept_key af_wlock_dkeys[AF_MAX];
+static struct dept_key af_elock_dkeys[AF_MAX];
+static struct dept_key af_kern_callback_dkeys[AF_MAX];
 
 /* Run time adjustable parameters. */
 __u32 sysctl_wmem_max __read_mostly = SK_WMEM_MAX;
@@ -1864,6 +1869,18 @@ static void sk_init_common(struct sock *sk)
 	lockdep_set_class_and_name(&sk->sk_callback_lock,
 			af_callback_keys + sk->sk_family,
 			af_family_clock_key_strings[sk->sk_family]);
+	dept_spin_reinit(&sk->sk_receive_queue.lock.dmap,
+			af_rlock_dkeys + sk->sk_family, -1,
+			af_family_rlock_key_strings[sk->sk_family]);
+	dept_spin_reinit(&sk->sk_write_queue.lock.dmap,
+			af_wlock_dkeys + sk->sk_family, -1,
+			af_family_wlock_key_strings[sk->sk_family]);
+	dept_spin_reinit(&sk->sk_error_queue.lock.dmap,
+			af_elock_dkeys + sk->sk_family, -1,
+			af_family_elock_key_strings[sk->sk_family]);
+	dept_rw_reinit(&sk->sk_callback_lock.dmap,
+			af_callback_dkeys + sk->sk_family, -1,
+			af_family_clock_key_strings[sk->sk_family]);
 }
 
 /**
@@ -2987,16 +3004,25 @@ void sock_init_data(struct socket *sock, struct sock *sk)
 	}
 
 	rwlock_init(&sk->sk_callback_lock);
-	if (sk->sk_kern_sock)
+	if (sk->sk_kern_sock) {
 		lockdep_set_class_and_name(
 			&sk->sk_callback_lock,
 			af_kern_callback_keys + sk->sk_family,
 			af_family_kern_clock_key_strings[sk->sk_family]);
-	else
+		dept_rw_reinit(
+			&sk->sk_callback_lock.dmap,
+			af_kern_callback_dkeys + sk->sk_family, -1,
+			af_family_kern_clock_key_strings[sk->sk_family]);
+	} else {
 		lockdep_set_class_and_name(
 			&sk->sk_callback_lock,
 			af_callback_keys + sk->sk_family,
 			af_family_clock_key_strings[sk->sk_family]);
+		dept_rw_reinit(
+			&sk->sk_callback_lock.dmap,
+			af_callback_dkeys + sk->sk_family, -1,
+			af_family_clock_key_strings[sk->sk_family]);
+	}
 
 	sk->sk_state_change	=	sock_def_wakeup;
 	sk->sk_data_ready	=	sock_def_readable;
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 701fc72..7862c46 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1463,6 +1463,7 @@ static int l2tp_tunnel_sock_create(struct net *net,
 }
 
 static struct lock_class_key l2tp_socket_class;
+static struct dept_key l2tp_socket_dkey;
 
 int l2tp_tunnel_create(struct net *net, int fd, int version, u32 tunnel_id, u32 peer_tunnel_id,
 		       struct l2tp_tunnel_cfg *cfg, struct l2tp_tunnel **tunnelp)
@@ -1595,6 +1596,8 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
 	sk->sk_destruct = &l2tp_tunnel_destruct;
 	lockdep_set_class_and_name(&sk->sk_lock.slock, &l2tp_socket_class,
 				   "l2tp_sock");
+	dept_spin_reinit(&sk->sk_lock.slock.dmap, &l2tp_socket_dkey, -1,
+			 "l2tp_sock");
 	sk->sk_allocation = GFP_ATOMIC;
 
 	if (tunnel->fd >= 0)
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index f76fac8..28b0ffa 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -64,6 +64,7 @@
 #define SYNC_PROTO_VER  1		/* Protocol version in header */
 
 static struct lock_class_key __ipvs_sync_key;
+static struct dept_key __ipvs_sync_dkey;
 /*
  *	IPVS sync connection entry
  *	Version 0, i.e. original version.
@@ -2034,10 +2035,8 @@ int stop_sync_thread(struct netns_ipvs *ipvs, int state)
  */
 int __net_init ip_vs_sync_net_init(struct netns_ipvs *ipvs)
 {
-	/*
-	 * TODO: Initialize the mutex with a valid dept_key.
-	 */
-	__mutex_init(&ipvs->sync_mutex, "ipvs->sync_mutex", &__ipvs_sync_key, NULL);
+	__mutex_init(&ipvs->sync_mutex, "ipvs->sync_mutex", &__ipvs_sync_key,
+			&__ipvs_sync_dkey);
 	spin_lock_init(&ipvs->sync_lock);
 	spin_lock_init(&ipvs->sync_buff_lock);
 	return 0;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index d2d1448..7374dfe 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -89,6 +89,7 @@ static inline int netlink_is_kernel(struct sock *sk)
 static DECLARE_WAIT_QUEUE_HEAD(nl_table_wait);
 
 static struct lock_class_key nlk_cb_mutex_keys[MAX_LINKS];
+static struct dept_key nlk_cb_mutex_dkeys[MAX_LINKS];
 
 static const char *const nlk_cb_mutex_key_strings[MAX_LINKS + 1] = {
 	"nlk_cb_mutex-ROUTE",
@@ -642,6 +643,9 @@ static int __netlink_create(struct net *net, struct socket *sock,
 		lockdep_set_class_and_name(nlk->cb_mutex,
 					   nlk_cb_mutex_keys + protocol,
 					   nlk_cb_mutex_key_strings[protocol]);
+		dept_spin_reinit(&nlk->cb_mutex->dmap,
+				 nlk_cb_mutex_dkeys + protocol, -1,
+				 nlk_cb_mutex_key_strings[protocol]);
 	}
 	init_waitqueue_head(&nlk->wait);
 
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index ed49769..a3c1a30 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -53,6 +53,7 @@ static void rxrpc_call_timer_expired(struct timer_list *t)
 }
 
 static struct lock_class_key rxrpc_call_user_mutex_lock_class_key;
+static struct dept_key rxrpc_call_user_mutex_lock_class_dkey;
 
 /*
  * find an extant server call
@@ -119,9 +120,12 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
 	/* Prevent lockdep reporting a deadlock false positive between the afs
 	 * filesystem and sys_sendmsg() via the mmap sem.
 	 */
-	if (rx->sk.sk_kern_sock)
+	if (rx->sk.sk_kern_sock) {
 		lockdep_set_class(&call->user_mutex,
 				  &rxrpc_call_user_mutex_lock_class_key);
+		dept_spin_reinit(&call->user_mutex.dmap,
+				  &rxrpc_call_user_mutex_lock_class_dkey, -1, NULL);
+	}
 
 	timer_setup(&call->timer, rxrpc_call_timer_expired, 0);
 	INIT_WORK(&call->processor, &rxrpc_process_call);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 54c4172..2d0e2a6 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -858,6 +858,12 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 	lockdep_set_class(&sch->busylock,
 			  dev->qdisc_tx_busylock ?: &qdisc_tx_busylock);
 
+	/*
+	 * TODO: Should re-initialize the map with a valid dept_key.
+	 */
+	dept_spin_nocheck(&sch->busylock.dmap);
+	dept_spin_nocheck(&sch->seqlock.dmap);
+
 	seqcount_init(&sch->running);
 	lockdep_set_class(&sch->running,
 			  dev->qdisc_running_key ?: &qdisc_running_key);
-- 
1.9.1

