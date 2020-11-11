Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935AA2AEF34
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgKKLJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:09:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:29753 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgKKLJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:09:06 -0500
IronPort-SDR: lgoT2c0ds/F/8FbYRxsbtaMD0z1lwwDBjKlc/XTvyVFWMtj1SrQNFmX6veL4ToVkPqPaygFb5m
 yH6k+NwdN/8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="170239331"
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="170239331"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 03:09:06 -0800
IronPort-SDR: O7HXYZvTBEI7OI0Hi4IaQrizwrFhNFAbD06Fsje1qvLzyah3LVJrObr5/oPZUaMGsC+cJVgQBI
 hIoa+pYSPBkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="365900525"
Received: from lkp-server02.sh.intel.com (HELO 5b2c7e53fe46) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2020 03:09:05 -0800
Received: from kbuild by 5b2c7e53fe46 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcnzs-00006P-Cj; Wed, 11 Nov 2020 11:09:04 +0000
Date:   Wed, 11 Nov 2020 19:08:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiao Ni <xni@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Song Liu <songliubraving@fb.com>
Subject: drivers/md/raid10.c:1698:39: warning: Uninitialized variable:
 first_r10bio
Message-ID: <202011111913.B2a3mcth-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eccc876724927ff3b9ff91f36f7b6b159e948f0c
commit: d3ee2d8415a6256c1c41e1be36e80e640c3e6359 md/raid10: improve discard request for far layout
date:   7 weeks ago
compiler: sparc64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"cppcheck warnings: (new ones prefixed by >>)"
   In file included from drivers/md/raid10.c:
>> drivers/md/raid10.c:1698:39: warning: Uninitialized variable: first_r10bio [uninitvar]
     r10_bio->master_bio = (struct bio *)first_r10bio;
                                         ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

   In file included from drivers/md/raid10.c:
   drivers/md/md.h:622:9: warning: Identical condition 'sd', second condition is always false [identicalConditionAfterEarlyExit]
    return sd;
           ^
   drivers/md/md.h:620:6: note: first condition
    if (sd)
        ^
   drivers/md/md.h:622:9: note: second condition
    return sd;
           ^
   drivers/md/raid10.c:3504:5: warning: Either the condition 'bio' is redundant or there is possible null pointer dereference: bio. [nullPointerRedundantCheck]
       bio->bi_next = biolist;
       ^
   drivers/md/raid10.c:3496:9: note: Assuming that condition 'bio' is not redundant
       if (bio)
           ^
   drivers/md/raid10.c:3504:5: note: Null pointer dereference
       bio->bi_next = biolist;
       ^
   drivers/md/raid10.c:3506:5: warning: Either the condition 'bio' is redundant or there is possible null pointer dereference: bio. [nullPointerRedundantCheck]
       bio->bi_end_io = end_sync_write;
       ^
   drivers/md/raid10.c:3496:9: note: Assuming that condition 'bio' is not redundant
       if (bio)
           ^
   drivers/md/raid10.c:3506:5: note: Null pointer dereference
       bio->bi_end_io = end_sync_write;
       ^

vim +1698 drivers/md/raid10.c

  1588	
  1589	/* There are some limitations to handle discard bio
  1590	 * 1st, the discard size is bigger than stripe_size*2.
  1591	 * 2st, if the discard bio spans reshape progress, we use the old way to
  1592	 * handle discard bio
  1593	 */
  1594	static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
  1595	{
  1596		struct r10conf *conf = mddev->private;
  1597		struct geom *geo = &conf->geo;
  1598		struct r10bio *r10_bio, *first_r10bio;
  1599		int far_copies = geo->far_copies;
  1600		bool first_copy = true;
  1601	
  1602		int disk;
  1603		sector_t chunk;
  1604		unsigned int stripe_size;
  1605		sector_t split_size;
  1606	
  1607		sector_t bio_start, bio_end;
  1608		sector_t first_stripe_index, last_stripe_index;
  1609		sector_t start_disk_offset;
  1610		unsigned int start_disk_index;
  1611		sector_t end_disk_offset;
  1612		unsigned int end_disk_index;
  1613		unsigned int remainder;
  1614	
  1615		if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery))
  1616			return -EAGAIN;
  1617	
  1618		wait_barrier(conf);
  1619	
  1620		/* Check reshape again to avoid reshape happens after checking
  1621		 * MD_RECOVERY_RESHAPE and before wait_barrier
  1622		 */
  1623		if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery))
  1624			goto out;
  1625	
  1626		stripe_size = geo->raid_disks << geo->chunk_shift;
  1627		bio_start = bio->bi_iter.bi_sector;
  1628		bio_end = bio_end_sector(bio);
  1629	
  1630		/* Maybe one discard bio is smaller than strip size or across one stripe
  1631		 * and discard region is larger than one stripe size. For far offset layout,
  1632		 * if the discard region is not aligned with stripe size, there is hole
  1633		 * when we submit discard bio to member disk. For simplicity, we only
  1634		 * handle discard bio which discard region is bigger than stripe_size*2
  1635		 */
  1636		if (bio_sectors(bio) < stripe_size*2)
  1637			goto out;
  1638	
  1639		/* For far and far offset layout, if bio is not aligned with stripe size,
  1640		 * it splits the part that is not aligned with strip size.
  1641		 */
  1642		div_u64_rem(bio_start, stripe_size, &remainder);
  1643		if ((far_copies > 1) && remainder) {
  1644			split_size = stripe_size - remainder;
  1645			bio = raid10_split_bio(conf, bio, split_size, false);
  1646		}
  1647		div_u64_rem(bio_end, stripe_size, &remainder);
  1648		if ((far_copies > 1) && remainder) {
  1649			split_size = bio_sectors(bio) - remainder;
  1650			bio = raid10_split_bio(conf, bio, split_size, true);
  1651		}
  1652	
  1653		bio_start = bio->bi_iter.bi_sector;
  1654		bio_end = bio_end_sector(bio);
  1655	
  1656		/* raid10 uses chunk as the unit to store data. It's similar like raid0.
  1657		 * One stripe contains the chunks from all member disk (one chunk from
  1658		 * one disk at the same HBA address). For layout detail, see 'man md 4'
  1659		 */
  1660		chunk = bio_start >> geo->chunk_shift;
  1661		chunk *= geo->near_copies;
  1662		first_stripe_index = chunk;
  1663		start_disk_index = sector_div(first_stripe_index, geo->raid_disks);
  1664		if (geo->far_offset)
  1665			first_stripe_index *= geo->far_copies;
  1666		start_disk_offset = (bio_start & geo->chunk_mask) +
  1667					(first_stripe_index << geo->chunk_shift);
  1668	
  1669		chunk = bio_end >> geo->chunk_shift;
  1670		chunk *= geo->near_copies;
  1671		last_stripe_index = chunk;
  1672		end_disk_index = sector_div(last_stripe_index, geo->raid_disks);
  1673		if (geo->far_offset)
  1674			last_stripe_index *= geo->far_copies;
  1675		end_disk_offset = (bio_end & geo->chunk_mask) +
  1676					(last_stripe_index << geo->chunk_shift);
  1677	
  1678	retry_discard:
  1679		r10_bio = mempool_alloc(&conf->r10bio_pool, GFP_NOIO);
  1680		r10_bio->mddev = mddev;
  1681		r10_bio->state = 0;
  1682		r10_bio->sectors = 0;
  1683		memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * geo->raid_disks);
  1684		wait_blocked_dev(mddev, r10_bio);
  1685	
  1686		/* For far layout it needs more than one r10bio to cover all regions.
  1687		 * Inspired by raid10_sync_request, we can use the first r10bio->master_bio
  1688		 * to record the discard bio. Other r10bio->master_bio record the first
  1689		 * r10bio. The first r10bio only release after all other r10bios finish.
  1690		 * The discard bio returns only first r10bio finishes
  1691		 */
  1692		if (first_copy) {
  1693			r10_bio->master_bio = bio;
  1694			set_bit(R10BIO_Discard, &r10_bio->state);
  1695			first_copy = false;
  1696			first_r10bio = r10_bio;
  1697		} else
> 1698			r10_bio->master_bio = (struct bio *)first_r10bio;
  1699	
  1700		rcu_read_lock();
  1701		for (disk = 0; disk < geo->raid_disks; disk++) {
  1702			struct md_rdev *rdev = rcu_dereference(conf->mirrors[disk].rdev);
  1703			struct md_rdev *rrdev = rcu_dereference(
  1704				conf->mirrors[disk].replacement);
  1705	
  1706			r10_bio->devs[disk].bio = NULL;
  1707			r10_bio->devs[disk].repl_bio = NULL;
  1708	
  1709			if (rdev && (test_bit(Faulty, &rdev->flags)))
  1710				rdev = NULL;
  1711			if (rrdev && (test_bit(Faulty, &rrdev->flags)))
  1712				rrdev = NULL;
  1713			if (!rdev && !rrdev)
  1714				continue;
  1715	
  1716			if (rdev) {
  1717				r10_bio->devs[disk].bio = bio;
  1718				atomic_inc(&rdev->nr_pending);
  1719			}
  1720			if (rrdev) {
  1721				r10_bio->devs[disk].repl_bio = bio;
  1722				atomic_inc(&rrdev->nr_pending);
  1723			}
  1724		}
  1725		rcu_read_unlock();
  1726	
  1727		atomic_set(&r10_bio->remaining, 1);
  1728		for (disk = 0; disk < geo->raid_disks; disk++) {
  1729			sector_t dev_start, dev_end;
  1730			struct bio *mbio, *rbio = NULL;
  1731			struct md_rdev *rdev = rcu_dereference(conf->mirrors[disk].rdev);
  1732			struct md_rdev *rrdev = rcu_dereference(
  1733				conf->mirrors[disk].replacement);
  1734	
  1735			/*
  1736			 * Now start to calculate the start and end address for each disk.
  1737			 * The space between dev_start and dev_end is the discard region.
  1738			 *
  1739			 * For dev_start, it needs to consider three conditions:
  1740			 * 1st, the disk is before start_disk, you can imagine the disk in
  1741			 * the next stripe. So the dev_start is the start address of next
  1742			 * stripe.
  1743			 * 2st, the disk is after start_disk, it means the disk is at the
  1744			 * same stripe of first disk
  1745			 * 3st, the first disk itself, we can use start_disk_offset directly
  1746			 */
  1747			if (disk < start_disk_index)
  1748				dev_start = (first_stripe_index + 1) * mddev->chunk_sectors;
  1749			else if (disk > start_disk_index)
  1750				dev_start = first_stripe_index * mddev->chunk_sectors;
  1751			else
  1752				dev_start = start_disk_offset;
  1753	
  1754			if (disk < end_disk_index)
  1755				dev_end = (last_stripe_index + 1) * mddev->chunk_sectors;
  1756			else if (disk > end_disk_index)
  1757				dev_end = last_stripe_index * mddev->chunk_sectors;
  1758			else
  1759				dev_end = end_disk_offset;
  1760	
  1761			/* It only handles discard bio which size is >= stripe size, so
  1762			 * dev_end > dev_start all the time
  1763			 */
  1764			if (r10_bio->devs[disk].bio) {
  1765				mbio = bio_clone_fast(bio, GFP_NOIO, &mddev->bio_set);
  1766				mbio->bi_end_io = raid10_end_discard_request;
  1767				mbio->bi_private = r10_bio;
  1768				r10_bio->devs[disk].bio = mbio;
  1769				r10_bio->devs[disk].devnum = disk;
  1770				atomic_inc(&r10_bio->remaining);
  1771				md_submit_discard_bio(mddev, rdev, mbio,
  1772						dev_start + choose_data_offset(r10_bio, rdev),
  1773						dev_end - dev_start);
  1774				bio_endio(mbio);
  1775			}
  1776			if (r10_bio->devs[disk].repl_bio) {
  1777				rbio = bio_clone_fast(bio, GFP_NOIO, &mddev->bio_set);
  1778				rbio->bi_end_io = raid10_end_discard_request;
  1779				rbio->bi_private = r10_bio;
  1780				r10_bio->devs[disk].repl_bio = rbio;
  1781				r10_bio->devs[disk].devnum = disk;
  1782				atomic_inc(&r10_bio->remaining);
  1783				md_submit_discard_bio(mddev, rrdev, rbio,
  1784						dev_start + choose_data_offset(r10_bio, rrdev),
  1785						dev_end - dev_start);
  1786				bio_endio(rbio);
  1787			}
  1788		}
  1789	
  1790		if (!geo->far_offset && --far_copies) {
  1791			first_stripe_index += geo->stride >> geo->chunk_shift;
  1792			start_disk_offset += geo->stride;
  1793			last_stripe_index += geo->stride >> geo->chunk_shift;
  1794			end_disk_offset += geo->stride;
  1795			atomic_inc(&first_r10bio->remaining);
  1796			raid_end_discard_bio(r10_bio);
  1797			wait_barrier(conf);
  1798			goto retry_discard;
  1799		}
  1800	
  1801		raid_end_discard_bio(r10_bio);
  1802	
  1803		return 0;
  1804	out:
  1805		allow_barrier(conf);
  1806		return -EAGAIN;
  1807	}
  1808	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
