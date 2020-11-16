Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED142B3C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 06:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKPF3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 00:29:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:63350 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgKPF3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 00:29:52 -0500
IronPort-SDR: mt+tCJiBREL/DPasen1lOLHpGzjMZOdpqhNOkq15Bv4rA2mCg10LORRkee33lwnWCqwSQhyjuL
 BoWJxBL3YFcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="234857462"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="gz'50?scan'50,208,50";a="234857462"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 21:29:45 -0800
IronPort-SDR: TQ/OAvqbpbJjqW3fjjSFbFD03sFMptsA4b+GPLKTIIQGUojiD9qpdwz99qWDzTkd1BOhtRwKXn
 YWr/HgemnCGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="gz'50?scan'50,208,50";a="310286138"
Received: from lkp-server01.sh.intel.com (HELO 18706234c166) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 15 Nov 2020 21:29:43 -0800
Received: from kbuild by 18706234c166 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1keX5C-00005N-G8; Mon, 16 Nov 2020 05:29:42 +0000
Date:   Mon, 16 Nov 2020 13:29:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: fs/btrfs/volumes.c:888:50: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202011161330.DF4ZdeRO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   09162bc32c880a791c6c0668ce0745cf7958f576
commit: 8d1a7aae89dc0c41ffb76fe1007dbba59d13881b btrfs: annotate device name rcu_string with __rcu
date:   6 weeks ago
config: s390-randconfig-s032-20201103 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-107-gaf3512a6-dirty
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

--x+6KMIRAuhnl3hBn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Q+ve7AkYhdaLse9f5IfJTSL6AQA=

--x+6KMIRAuhnl3hBn--
