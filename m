Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17282921ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 06:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgJSE2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 00:28:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:38074 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgJSE2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 00:28:40 -0400
IronPort-SDR: ClqOgj6k4U8uf0GG+7/D4OSWPW+PoMRZP5OMHciOrtvoYoG4V81hQcGohnYBGZS7BPjYXoNik/
 ebOpubw+D1ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="167081479"
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="gz'50?scan'50,208,50";a="167081479"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 21:28:34 -0700
IronPort-SDR: dfFBH89OCgVVJYZSQdjZrdGY/CszzrUSJLcgUNS6tvM0pkZ+KwisNrLMU/dfs75Ma42Jesu2Vh
 KI0SHwW6501g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="gz'50?scan'50,208,50";a="347286226"
Received: from lkp-server01.sh.intel.com (HELO 0318c0cac2d8) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Oct 2020 21:28:32 -0700
Received: from kbuild by 0318c0cac2d8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kUMmd-0000Gu-Bi; Mon, 19 Oct 2020 04:28:31 +0000
Date:   Mon, 19 Oct 2020 12:27:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: fs/btrfs/volumes.c:888:50: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202010191240.KEASeyru-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7cf726a59435301046250c42131554d9ccc566b8
commit: 8d1a7aae89dc0c41ffb76fe1007dbba59d13881b btrfs: annotate device name rcu_string with __rcu
date:   12 days ago
config: s390-randconfig-s032-20201019 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-rc1-2-g368fd9ce-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d1a7aae89dc0c41ffb76fe1007dbba59d13881b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8d1a7aae89dc0c41ffb76fe1007dbba59d13881b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   fs/btrfs/volumes.c:374:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcu_string *str @@     got struct rcu_string [noderef] __rcu *name @@
   fs/btrfs/volumes.c:374:31: sparse:     expected struct rcu_string *str
   fs/btrfs/volumes.c:374:31: sparse:     got struct rcu_string [noderef] __rcu *name
   fs/btrfs/volumes.c:631:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:631:43: sparse:     expected char const *device_path
   fs/btrfs/volumes.c:631:43: sparse:     got char [noderef] __rcu *
>> fs/btrfs/volumes.c:888:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *s1 @@     got char [noderef] __rcu * @@
>> fs/btrfs/volumes.c:888:50: sparse:     expected char const *s1
   fs/btrfs/volumes.c:888:50: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:963:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcu_string *str @@     got struct rcu_string [noderef] __rcu *name @@
   fs/btrfs/volumes.c:963:39: sparse:     expected struct rcu_string *str
   fs/btrfs/volumes.c:963:39: sparse:     got struct rcu_string [noderef] __rcu *name
   fs/btrfs/volumes.c:1018:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *src @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:1018:58: sparse:     expected char const *src
   fs/btrfs/volumes.c:1018:58: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:2165:49: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:2165:49: sparse:     expected char const *device_path
   fs/btrfs/volumes.c:2165:49: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:2273:41: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:2273:41: sparse:     expected char const *device_path
   fs/btrfs/volumes.c:2273:41: sparse:     got char [noderef] __rcu *

vim +888 fs/btrfs/volumes.c

1362089d2ad7e20 Nikolay Borisov           2020-01-10  745  
1362089d2ad7e20 Nikolay Borisov           2020-01-10  746  static struct btrfs_fs_devices *find_fsid_reverted_metadata(
1362089d2ad7e20 Nikolay Borisov           2020-01-10  747  				struct btrfs_super_block *disk_super)
1362089d2ad7e20 Nikolay Borisov           2020-01-10  748  {
1362089d2ad7e20 Nikolay Borisov           2020-01-10  749  	struct btrfs_fs_devices *fs_devices;
1362089d2ad7e20 Nikolay Borisov           2020-01-10  750  
1362089d2ad7e20 Nikolay Borisov           2020-01-10  751  	/*
1362089d2ad7e20 Nikolay Borisov           2020-01-10  752  	 * Handle the case where the scanned device is part of an fs whose last
1362089d2ad7e20 Nikolay Borisov           2020-01-10  753  	 * metadata UUID change reverted it to the original FSID. At the same
1362089d2ad7e20 Nikolay Borisov           2020-01-10  754  	 * time * fs_devices was first created by another constitutent device
1362089d2ad7e20 Nikolay Borisov           2020-01-10  755  	 * which didn't fully observe the operation. This results in an
1362089d2ad7e20 Nikolay Borisov           2020-01-10  756  	 * btrfs_fs_devices created with metadata/fsid different AND
1362089d2ad7e20 Nikolay Borisov           2020-01-10  757  	 * btrfs_fs_devices::fsid_change set AND the metadata_uuid of the
1362089d2ad7e20 Nikolay Borisov           2020-01-10  758  	 * fs_devices equal to the FSID of the disk.
1362089d2ad7e20 Nikolay Borisov           2020-01-10  759  	 */
1362089d2ad7e20 Nikolay Borisov           2020-01-10  760  	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
1362089d2ad7e20 Nikolay Borisov           2020-01-10  761  		if (memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
1362089d2ad7e20 Nikolay Borisov           2020-01-10  762  			   BTRFS_FSID_SIZE) != 0 &&
1362089d2ad7e20 Nikolay Borisov           2020-01-10  763  		    memcmp(fs_devices->metadata_uuid, disk_super->fsid,
1362089d2ad7e20 Nikolay Borisov           2020-01-10  764  			   BTRFS_FSID_SIZE) == 0 &&
1362089d2ad7e20 Nikolay Borisov           2020-01-10  765  		    fs_devices->fsid_change)
1362089d2ad7e20 Nikolay Borisov           2020-01-10  766  			return fs_devices;
1362089d2ad7e20 Nikolay Borisov           2020-01-10  767  	}
1362089d2ad7e20 Nikolay Borisov           2020-01-10  768  
1362089d2ad7e20 Nikolay Borisov           2020-01-10  769  	return NULL;
1362089d2ad7e20 Nikolay Borisov           2020-01-10  770  }
60999ca4b4033ee David Sterba              2014-03-26  771  /*
60999ca4b4033ee David Sterba              2014-03-26  772   * Add new device to list of registered devices
60999ca4b4033ee David Sterba              2014-03-26  773   *
60999ca4b4033ee David Sterba              2014-03-26  774   * Returns:
e124ece53edf3a8 Anand Jain                2018-01-18  775   * device pointer which was just added or updated when successful
e124ece53edf3a8 Anand Jain                2018-01-18  776   * error pointer when failed
60999ca4b4033ee David Sterba              2014-03-26  777   */
e124ece53edf3a8 Anand Jain                2018-01-18  778  static noinline struct btrfs_device *device_list_add(const char *path,
4306a97449f9a0f Anand Jain                2018-05-29  779  			   struct btrfs_super_block *disk_super,
4306a97449f9a0f Anand Jain                2018-05-29  780  			   bool *new_device_added)
8a4b83cc8bd75fc Chris Mason               2008-03-24  781  {
8a4b83cc8bd75fc Chris Mason               2008-03-24  782  	struct btrfs_device *device;
7a62d0f07377b51 Nikolay Borisov           2018-10-30  783  	struct btrfs_fs_devices *fs_devices = NULL;
606686eeac4550d Josef Bacik               2012-06-04  784  	struct rcu_string *name;
8a4b83cc8bd75fc Chris Mason               2008-03-24  785  	u64 found_transid = btrfs_super_generation(disk_super);
3acbcbfc8f06d4a Anand Jain                2018-01-18  786  	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
7239ff4b2be8ec0 Nikolay Borisov           2018-10-30  787  	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
7239ff4b2be8ec0 Nikolay Borisov           2018-10-30  788  		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
d1a63002829a4d8 Nikolay Borisov           2018-10-30  789  	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
d1a63002829a4d8 Nikolay Borisov           2018-10-30  790  					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
7239ff4b2be8ec0 Nikolay Borisov           2018-10-30  791  
cc5de4e70256cbf Nikolay Borisov           2018-10-30  792  	if (fsid_change_in_progress) {
c0d81c7cb236782 Su Yue                    2020-01-10  793  		if (!has_metadata_uuid)
7a62d0f07377b51 Nikolay Borisov           2018-10-30  794  			fs_devices = find_fsid_inprogress(disk_super);
c0d81c7cb236782 Su Yue                    2020-01-10  795  		else
cc5de4e70256cbf Nikolay Borisov           2018-10-30  796  			fs_devices = find_fsid_changed(disk_super);
7a62d0f07377b51 Nikolay Borisov           2018-10-30  797  	} else if (has_metadata_uuid) {
c6730a0e5778bf2 Su Yue                    2020-01-10  798  		fs_devices = find_fsid_with_metadata_uuid(disk_super);
7a62d0f07377b51 Nikolay Borisov           2018-10-30  799  	} else {
1362089d2ad7e20 Nikolay Borisov           2020-01-10  800  		fs_devices = find_fsid_reverted_metadata(disk_super);
1362089d2ad7e20 Nikolay Borisov           2020-01-10  801  		if (!fs_devices)
7a62d0f07377b51 Nikolay Borisov           2018-10-30  802  			fs_devices = find_fsid(disk_super->fsid, NULL);
7a62d0f07377b51 Nikolay Borisov           2018-10-30  803  	}
7a62d0f07377b51 Nikolay Borisov           2018-10-30  804  
7a62d0f07377b51 Nikolay Borisov           2018-10-30  805  
8a4b83cc8bd75fc Chris Mason               2008-03-24  806  	if (!fs_devices) {
7239ff4b2be8ec0 Nikolay Borisov           2018-10-30  807  		if (has_metadata_uuid)
7239ff4b2be8ec0 Nikolay Borisov           2018-10-30  808  			fs_devices = alloc_fs_devices(disk_super->fsid,
7239ff4b2be8ec0 Nikolay Borisov           2018-10-30  809  						      disk_super->metadata_uuid);
7239ff4b2be8ec0 Nikolay Borisov           2018-10-30  810  		else
7239ff4b2be8ec0 Nikolay Borisov           2018-10-30  811  			fs_devices = alloc_fs_devices(disk_super->fsid, NULL);
7239ff4b2be8ec0 Nikolay Borisov           2018-10-30  812  
2208a378f35fea7 Ilya Dryomov              2013-08-12  813  		if (IS_ERR(fs_devices))
e124ece53edf3a8 Anand Jain                2018-01-18  814  			return ERR_CAST(fs_devices);
2208a378f35fea7 Ilya Dryomov              2013-08-12  815  
92900e5160a5444 Al Viro                   2019-01-27  816  		fs_devices->fsid_change = fsid_change_in_progress;
92900e5160a5444 Al Viro                   2019-01-27  817  
9c6d173ea6e4c8c Anand Jain                2018-05-29  818  		mutex_lock(&fs_devices->device_list_mutex);
c4babc5e38e94e7 Anand Jain                2018-04-12  819  		list_add(&fs_devices->fs_list, &fs_uuids);
2208a378f35fea7 Ilya Dryomov              2013-08-12  820  
8a4b83cc8bd75fc Chris Mason               2008-03-24  821  		device = NULL;
8a4b83cc8bd75fc Chris Mason               2008-03-24  822  	} else {
9c6d173ea6e4c8c Anand Jain                2018-05-29  823  		mutex_lock(&fs_devices->device_list_mutex);
09ba3bc9dd15045 Anand Jain                2019-01-19  824  		device = btrfs_find_device(fs_devices, devid,
09ba3bc9dd15045 Anand Jain                2019-01-19  825  				disk_super->dev_item.uuid, NULL, false);
7a62d0f07377b51 Nikolay Borisov           2018-10-30  826  
7a62d0f07377b51 Nikolay Borisov           2018-10-30  827  		/*
7a62d0f07377b51 Nikolay Borisov           2018-10-30  828  		 * If this disk has been pulled into an fs devices created by
7a62d0f07377b51 Nikolay Borisov           2018-10-30  829  		 * a device which had the CHANGING_FSID_V2 flag then replace the
7a62d0f07377b51 Nikolay Borisov           2018-10-30  830  		 * metadata_uuid/fsid values of the fs_devices.
7a62d0f07377b51 Nikolay Borisov           2018-10-30  831  		 */
1362089d2ad7e20 Nikolay Borisov           2020-01-10  832  		if (fs_devices->fsid_change &&
7a62d0f07377b51 Nikolay Borisov           2018-10-30  833  		    found_transid > fs_devices->latest_generation) {
7a62d0f07377b51 Nikolay Borisov           2018-10-30  834  			memcpy(fs_devices->fsid, disk_super->fsid,
7a62d0f07377b51 Nikolay Borisov           2018-10-30  835  					BTRFS_FSID_SIZE);
1362089d2ad7e20 Nikolay Borisov           2020-01-10  836  
1362089d2ad7e20 Nikolay Borisov           2020-01-10  837  			if (has_metadata_uuid)
1362089d2ad7e20 Nikolay Borisov           2020-01-10  838  				memcpy(fs_devices->metadata_uuid,
1362089d2ad7e20 Nikolay Borisov           2020-01-10  839  				       disk_super->metadata_uuid,
1362089d2ad7e20 Nikolay Borisov           2020-01-10  840  				       BTRFS_FSID_SIZE);
1362089d2ad7e20 Nikolay Borisov           2020-01-10  841  			else
7a62d0f07377b51 Nikolay Borisov           2018-10-30  842  				memcpy(fs_devices->metadata_uuid,
1362089d2ad7e20 Nikolay Borisov           2020-01-10  843  				       disk_super->fsid, BTRFS_FSID_SIZE);
7a62d0f07377b51 Nikolay Borisov           2018-10-30  844  
7a62d0f07377b51 Nikolay Borisov           2018-10-30  845  			fs_devices->fsid_change = false;
7a62d0f07377b51 Nikolay Borisov           2018-10-30  846  		}
8a4b83cc8bd75fc Chris Mason               2008-03-24  847  	}
443f24fee731703 Miao Xie                  2014-07-24  848  
8a4b83cc8bd75fc Chris Mason               2008-03-24  849  	if (!device) {
9c6d173ea6e4c8c Anand Jain                2018-05-29  850  		if (fs_devices->opened) {
9c6d173ea6e4c8c Anand Jain                2018-05-29  851  			mutex_unlock(&fs_devices->device_list_mutex);
e124ece53edf3a8 Anand Jain                2018-01-18  852  			return ERR_PTR(-EBUSY);
9c6d173ea6e4c8c Anand Jain                2018-05-29  853  		}
2b82032c34ec405 Yan Zheng                 2008-11-17  854  
12bd2fc0d2f589f Ilya Dryomov              2013-08-23  855  		device = btrfs_alloc_device(NULL, &devid,
12bd2fc0d2f589f Ilya Dryomov              2013-08-23  856  					    disk_super->dev_item.uuid);
12bd2fc0d2f589f Ilya Dryomov              2013-08-23  857  		if (IS_ERR(device)) {
9c6d173ea6e4c8c Anand Jain                2018-05-29  858  			mutex_unlock(&fs_devices->device_list_mutex);
8a4b83cc8bd75fc Chris Mason               2008-03-24  859  			/* we can safely leave the fs_devices entry around */
e124ece53edf3a8 Anand Jain                2018-01-18  860  			return device;
8a4b83cc8bd75fc Chris Mason               2008-03-24  861  		}
606686eeac4550d Josef Bacik               2012-06-04  862  
606686eeac4550d Josef Bacik               2012-06-04  863  		name = rcu_string_strdup(path, GFP_NOFS);
606686eeac4550d Josef Bacik               2012-06-04  864  		if (!name) {
a425f9d4755a14f David Sterba              2018-03-20  865  			btrfs_free_device(device);
9c6d173ea6e4c8c Anand Jain                2018-05-29  866  			mutex_unlock(&fs_devices->device_list_mutex);
e124ece53edf3a8 Anand Jain                2018-01-18  867  			return ERR_PTR(-ENOMEM);
8a4b83cc8bd75fc Chris Mason               2008-03-24  868  		}
606686eeac4550d Josef Bacik               2012-06-04  869  		rcu_assign_pointer(device->name, name);
90519d66abbccc2 Arne Jansen               2011-05-23  870  
1f78160ce1b1b8e Xiao Guangrong            2011-04-20  871  		list_add_rcu(&device->dev_list, &fs_devices->devices);
f71717502460c5c Filipe David Borba Manana 2013-08-12  872  		fs_devices->num_devices++;
e5e9a5206a171b2 Chris Mason               2009-06-10  873  
2b82032c34ec405 Yan Zheng                 2008-11-17  874  		device->fs_devices = fs_devices;
4306a97449f9a0f Anand Jain                2018-05-29  875  		*new_device_added = true;
327f18cc7f44bc0 Anand Jain                2018-01-18  876  
327f18cc7f44bc0 Anand Jain                2018-01-18  877  		if (disk_super->label[0])
aa6c0df73e3b3fc Anand Jain                2019-10-02  878  			pr_info(
aa6c0df73e3b3fc Anand Jain                2019-10-02  879  	"BTRFS: device label %s devid %llu transid %llu %s scanned by %s (%d)\n",
aa6c0df73e3b3fc Anand Jain                2019-10-02  880  				disk_super->label, devid, found_transid, path,
aa6c0df73e3b3fc Anand Jain                2019-10-02  881  				current->comm, task_pid_nr(current));
327f18cc7f44bc0 Anand Jain                2018-01-18  882  		else
aa6c0df73e3b3fc Anand Jain                2019-10-02  883  			pr_info(
aa6c0df73e3b3fc Anand Jain                2019-10-02  884  	"BTRFS: device fsid %pU devid %llu transid %llu %s scanned by %s (%d)\n",
aa6c0df73e3b3fc Anand Jain                2019-10-02  885  				disk_super->fsid, devid, found_transid, path,
aa6c0df73e3b3fc Anand Jain                2019-10-02  886  				current->comm, task_pid_nr(current));
327f18cc7f44bc0 Anand Jain                2018-01-18  887  
606686eeac4550d Josef Bacik               2012-06-04 @888  	} else if (!device->name || strcmp(device->name->str, path)) {
b96de000bc8bc96 Anand Jain                2014-07-03  889  		/*
b96de000bc8bc96 Anand Jain                2014-07-03  890  		 * When FS is already mounted.
b96de000bc8bc96 Anand Jain                2014-07-03  891  		 * 1. If you are here and if the device->name is NULL that
b96de000bc8bc96 Anand Jain                2014-07-03  892  		 *    means this device was missing at time of FS mount.
b96de000bc8bc96 Anand Jain                2014-07-03  893  		 * 2. If you are here and if the device->name is different
b96de000bc8bc96 Anand Jain                2014-07-03  894  		 *    from 'path' that means either
b96de000bc8bc96 Anand Jain                2014-07-03  895  		 *      a. The same device disappeared and reappeared with
b96de000bc8bc96 Anand Jain                2014-07-03  896  		 *         different name. or
b96de000bc8bc96 Anand Jain                2014-07-03  897  		 *      b. The missing-disk-which-was-replaced, has
b96de000bc8bc96 Anand Jain                2014-07-03  898  		 *         reappeared now.
b96de000bc8bc96 Anand Jain                2014-07-03  899  		 *
b96de000bc8bc96 Anand Jain                2014-07-03  900  		 * We must allow 1 and 2a above. But 2b would be a spurious
b96de000bc8bc96 Anand Jain                2014-07-03  901  		 * and unintentional.
b96de000bc8bc96 Anand Jain                2014-07-03  902  		 *
b96de000bc8bc96 Anand Jain                2014-07-03  903  		 * Further in case of 1 and 2a above, the disk at 'path'
b96de000bc8bc96 Anand Jain                2014-07-03  904  		 * would have missed some transaction when it was away and
b96de000bc8bc96 Anand Jain                2014-07-03  905  		 * in case of 2a the stale bdev has to be updated as well.
b96de000bc8bc96 Anand Jain                2014-07-03  906  		 * 2b must not be allowed at all time.
b96de000bc8bc96 Anand Jain                2014-07-03  907  		 */
b96de000bc8bc96 Anand Jain                2014-07-03  908  
b96de000bc8bc96 Anand Jain                2014-07-03  909  		/*
0f23ae74f589304 Chris Mason               2014-09-18  910  		 * For now, we do allow update to btrfs_fs_device through the
0f23ae74f589304 Chris Mason               2014-09-18  911  		 * btrfs dev scan cli after FS has been mounted.  We're still
0f23ae74f589304 Chris Mason               2014-09-18  912  		 * tracking a problem where systems fail mount by subvolume id
0f23ae74f589304 Chris Mason               2014-09-18  913  		 * when we reject replacement on a mounted FS.
b96de000bc8bc96 Anand Jain                2014-07-03  914  		 */
0f23ae74f589304 Chris Mason               2014-09-18  915  		if (!fs_devices->opened && found_transid < device->generation) {
77bdae4d136e167 Anand Jain                2014-07-03  916  			/*
77bdae4d136e167 Anand Jain                2014-07-03  917  			 * That is if the FS is _not_ mounted and if you
77bdae4d136e167 Anand Jain                2014-07-03  918  			 * are here, that means there is more than one
77bdae4d136e167 Anand Jain                2014-07-03  919  			 * disk with same uuid and devid.We keep the one
77bdae4d136e167 Anand Jain                2014-07-03  920  			 * with larger generation number or the last-in if
77bdae4d136e167 Anand Jain                2014-07-03  921  			 * generation are equal.
77bdae4d136e167 Anand Jain                2014-07-03  922  			 */
9c6d173ea6e4c8c Anand Jain                2018-05-29  923  			mutex_unlock(&fs_devices->device_list_mutex);
e124ece53edf3a8 Anand Jain                2018-01-18  924  			return ERR_PTR(-EEXIST);
77bdae4d136e167 Anand Jain                2014-07-03  925  		}
b96de000bc8bc96 Anand Jain                2014-07-03  926  
a9261d4125c97ce Anand Jain                2018-10-15  927  		/*
a9261d4125c97ce Anand Jain                2018-10-15  928  		 * We are going to replace the device path for a given devid,
a9261d4125c97ce Anand Jain                2018-10-15  929  		 * make sure it's the same device if the device is mounted
a9261d4125c97ce Anand Jain                2018-10-15  930  		 */
a9261d4125c97ce Anand Jain                2018-10-15  931  		if (device->bdev) {
a9261d4125c97ce Anand Jain                2018-10-15  932  			struct block_device *path_bdev;
a9261d4125c97ce Anand Jain                2018-10-15  933  
a9261d4125c97ce Anand Jain                2018-10-15  934  			path_bdev = lookup_bdev(path);
a9261d4125c97ce Anand Jain                2018-10-15  935  			if (IS_ERR(path_bdev)) {
a9261d4125c97ce Anand Jain                2018-10-15  936  				mutex_unlock(&fs_devices->device_list_mutex);
a9261d4125c97ce Anand Jain                2018-10-15  937  				return ERR_CAST(path_bdev);
a9261d4125c97ce Anand Jain                2018-10-15  938  			}
a9261d4125c97ce Anand Jain                2018-10-15  939  
a9261d4125c97ce Anand Jain                2018-10-15  940  			if (device->bdev != path_bdev) {
a9261d4125c97ce Anand Jain                2018-10-15  941  				bdput(path_bdev);
a9261d4125c97ce Anand Jain                2018-10-15  942  				mutex_unlock(&fs_devices->device_list_mutex);
a9261d4125c97ce Anand Jain                2018-10-15  943  				btrfs_warn_in_rcu(device->fs_info,
79dae17d8d44b2d Anand Jain                2020-09-03  944  	"duplicate device %s devid %llu generation %llu scanned by %s (%d)",
79dae17d8d44b2d Anand Jain                2020-09-03  945  						  path, devid, found_transid,
79dae17d8d44b2d Anand Jain                2020-09-03  946  						  current->comm,
79dae17d8d44b2d Anand Jain                2020-09-03  947  						  task_pid_nr(current));
a9261d4125c97ce Anand Jain                2018-10-15  948  				return ERR_PTR(-EEXIST);
a9261d4125c97ce Anand Jain                2018-10-15  949  			}
a9261d4125c97ce Anand Jain                2018-10-15  950  			bdput(path_bdev);
a9261d4125c97ce Anand Jain                2018-10-15  951  			btrfs_info_in_rcu(device->fs_info,
79dae17d8d44b2d Anand Jain                2020-09-03  952  	"devid %llu device path %s changed to %s scanned by %s (%d)",
79dae17d8d44b2d Anand Jain                2020-09-03  953  					  devid, rcu_str_deref(device->name),
79dae17d8d44b2d Anand Jain                2020-09-03  954  					  path, current->comm,
79dae17d8d44b2d Anand Jain                2020-09-03  955  					  task_pid_nr(current));
a9261d4125c97ce Anand Jain                2018-10-15  956  		}
a9261d4125c97ce Anand Jain                2018-10-15  957  
606686eeac4550d Josef Bacik               2012-06-04  958  		name = rcu_string_strdup(path, GFP_NOFS);
9c6d173ea6e4c8c Anand Jain                2018-05-29  959  		if (!name) {
9c6d173ea6e4c8c Anand Jain                2018-05-29  960  			mutex_unlock(&fs_devices->device_list_mutex);
e124ece53edf3a8 Anand Jain                2018-01-18  961  			return ERR_PTR(-ENOMEM);
9c6d173ea6e4c8c Anand Jain                2018-05-29  962  		}
606686eeac4550d Josef Bacik               2012-06-04  963  		rcu_string_free(device->name);
606686eeac4550d Josef Bacik               2012-06-04  964  		rcu_assign_pointer(device->name, name);
e6e674bd4d54fe8 Anand Jain                2017-12-04  965  		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
cd02dca56442e15 Chris Mason               2010-12-13  966  			fs_devices->missing_devices--;
e6e674bd4d54fe8 Anand Jain                2017-12-04  967  			clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
cd02dca56442e15 Chris Mason               2010-12-13  968  		}
8a4b83cc8bd75fc Chris Mason               2008-03-24  969  	}
8a4b83cc8bd75fc Chris Mason               2008-03-24  970  
77bdae4d136e167 Anand Jain                2014-07-03  971  	/*
77bdae4d136e167 Anand Jain                2014-07-03  972  	 * Unmount does not free the btrfs_device struct but would zero
77bdae4d136e167 Anand Jain                2014-07-03  973  	 * generation along with most of the other members. So just update
77bdae4d136e167 Anand Jain                2014-07-03  974  	 * it back. We need it to pick the disk with largest generation
77bdae4d136e167 Anand Jain                2014-07-03  975  	 * (as above).
77bdae4d136e167 Anand Jain                2014-07-03  976  	 */
d1a63002829a4d8 Nikolay Borisov           2018-10-30  977  	if (!fs_devices->opened) {
77bdae4d136e167 Anand Jain                2014-07-03  978  		device->generation = found_transid;
d1a63002829a4d8 Nikolay Borisov           2018-10-30  979  		fs_devices->latest_generation = max_t(u64, found_transid,
d1a63002829a4d8 Nikolay Borisov           2018-10-30  980  						fs_devices->latest_generation);
d1a63002829a4d8 Nikolay Borisov           2018-10-30  981  	}
77bdae4d136e167 Anand Jain                2014-07-03  982  
f2788d2f76cafef Anand Jain                2018-01-18  983  	fs_devices->total_devices = btrfs_super_num_devices(disk_super);
f2788d2f76cafef Anand Jain                2018-01-18  984  
9c6d173ea6e4c8c Anand Jain                2018-05-29  985  	mutex_unlock(&fs_devices->device_list_mutex);
e124ece53edf3a8 Anand Jain                2018-01-18  986  	return device;
8a4b83cc8bd75fc Chris Mason               2008-03-24  987  }
8a4b83cc8bd75fc Chris Mason               2008-03-24  988  

:::::: The code at line 888 was first introduced by commit
:::::: 606686eeac4550d2212bf3d621a810407ef5e9bf Btrfs: use rcu to protect device->name

:::::: TO: Josef Bacik <josef@redhat.com>
:::::: CC: Chris Mason <chris.mason@oracle.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--LQksG6bCIzRHxTLp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
3xL6tA0cUPQz0f8AzFwEGp17AQA=

--LQksG6bCIzRHxTLp--
