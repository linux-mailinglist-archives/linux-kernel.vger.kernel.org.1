Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC9721A434E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 10:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDJIEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 04:04:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:40616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgDJIEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 04:04:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8B31DAD23;
        Fri, 10 Apr 2020 08:03:55 +0000 (UTC)
Subject: Re: [PATCH] bcache: Convert pr_<level> uses to a more typical style
To:     Joe Perches <joe@perches.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1927b7286ac7a14345708f810796c09337ea389a.1586496687.git.joe@perches.com>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <c1bbae85-5656-7db7-be45-0115b909738b@suse.de>
Date:   Fri, 10 Apr 2020 16:03:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1927b7286ac7a14345708f810796c09337ea389a.1586496687.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/10 1:34 下午, Joe Perches wrote:
> Remove the trailing newline from the define of pr_fmt and add newlines
> to the uses.
> 
> Miscellanea:
> 
> o Convert bch_bkey_dump from multiple uses of pr_err to pr_cont
>   as the earlier conversion was inappropriate done causing multiple
>   lines to be emitted where only a single output line was desired
> o Use vsprintf extension %pV in bch_cache_set_error to avoid multiple
>   line output where only a single line output was desired
> o Coalesce formats
> 
> Fixes: 6ae63e3501c4 ("bcache: replace printk() by pr_*() routines")
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Hi Joe,

I will add this patch into my for-next. Thank you for the fix.

Coly Li


> ---
>  drivers/md/bcache/bcache.h    |   2 +-
>  drivers/md/bcache/bset.c      |   6 +-
>  drivers/md/bcache/btree.c     |  14 ++--
>  drivers/md/bcache/extents.c   |  12 ++--
>  drivers/md/bcache/io.c        |   8 +--
>  drivers/md/bcache/journal.c   |  34 +++++-----
>  drivers/md/bcache/request.c   |   6 +-
>  drivers/md/bcache/super.c     | 123 +++++++++++++++++-----------------
>  drivers/md/bcache/sysfs.c     |   8 +--
>  drivers/md/bcache/writeback.c |   6 +-
>  10 files changed, 110 insertions(+), 109 deletions(-)
> 
> diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
> index 74a984..221e01 100644
> --- a/drivers/md/bcache/bcache.h
> +++ b/drivers/md/bcache/bcache.h
> @@ -176,7 +176,7 @@
>   * - updates to non leaf nodes just happen synchronously (see btree_split()).
>   */
>  
> -#define pr_fmt(fmt) "bcache: %s() " fmt "\n", __func__
> +#define pr_fmt(fmt) "bcache: %s() " fmt, __func__
>  
>  #include <linux/bcache.h>
>  #include <linux/bio.h>
> diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
> index 438530..4995fc 100644
> --- a/drivers/md/bcache/bset.c
> +++ b/drivers/md/bcache/bset.c
> @@ -6,7 +6,7 @@
>   * Copyright 2012 Google, Inc.
>   */
>  
> -#define pr_fmt(fmt) "bcache: %s() " fmt "\n", __func__
> +#define pr_fmt(fmt) "bcache: %s() " fmt, __func__
>  
>  #include "util.h"
>  #include "bset.h"
> @@ -31,7 +31,7 @@ void bch_dump_bset(struct btree_keys *b, struct bset *i, unsigned int set)
>  		if (b->ops->key_dump)
>  			b->ops->key_dump(b, k);
>  		else
> -			pr_err("%llu:%llu\n", KEY_INODE(k), KEY_OFFSET(k));
> +			pr_cont("%llu:%llu\n", KEY_INODE(k), KEY_OFFSET(k));
>  
>  		if (next < bset_bkey_last(i) &&
>  		    bkey_cmp(k, b->ops->is_extents ?
> @@ -1225,7 +1225,7 @@ static void btree_mergesort(struct btree_keys *b, struct bset *out,
>  
>  	out->keys = last ? (uint64_t *) bkey_next(last) - out->d : 0;
>  
> -	pr_debug("sorted %i keys", out->keys);
> +	pr_debug("sorted %i keys\n", out->keys);
>  }
>  
>  static void __btree_sort(struct btree_keys *b, struct btree_iter *iter,
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index 72856e..fd0189 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -619,7 +619,7 @@ static int mca_reap(struct btree *b, unsigned int min_order, bool flush)
>  	 * and BTREE_NODE_journal_flush bit cleared by btree_flush_write().
>  	 */
>  	if (btree_node_journal_flush(b)) {
> -		pr_debug("bnode %p is flushing by journal, retry", b);
> +		pr_debug("bnode %p is flushing by journal, retry\n", b);
>  		mutex_unlock(&b->write_lock);
>  		udelay(1);
>  		goto retry;
> @@ -802,7 +802,7 @@ int bch_btree_cache_alloc(struct cache_set *c)
>  	c->shrink.batch = c->btree_pages * 2;
>  
>  	if (register_shrinker(&c->shrink))
> -		pr_warn("bcache: %s: could not register shrinker",
> +		pr_warn("bcache: %s: could not register shrinker\n",
>  				__func__);
>  
>  	return 0;
> @@ -1054,7 +1054,7 @@ static void btree_node_free(struct btree *b)
>  	 */
>  	if (btree_node_journal_flush(b)) {
>  		mutex_unlock(&b->write_lock);
> -		pr_debug("bnode %p journal_flush set, retry", b);
> +		pr_debug("bnode %p journal_flush set, retry\n", b);
>  		udelay(1);
>  		goto retry;
>  	}
> @@ -1798,7 +1798,7 @@ static void bch_btree_gc(struct cache_set *c)
>  			schedule_timeout_interruptible(msecs_to_jiffies
>  						       (GC_SLEEP_MS));
>  		else if (ret)
> -			pr_warn("gc failed!");
> +			pr_warn("gc failed!\n");
>  	} while (ret && !test_bit(CACHE_SET_IO_DISABLE, &c->flags));
>  
>  	bch_btree_gc_finish(c);
> @@ -2045,7 +2045,7 @@ int bch_btree_check(struct cache_set *c)
>  				    &check_state->infos[i],
>  				    name);
>  		if (IS_ERR(check_state->infos[i].thread)) {
> -			pr_err("fails to run thread bch_btrchk[%d]", i);
> +			pr_err("fails to run thread bch_btrchk[%d]\n", i);
>  			for (--i; i >= 0; i--)
>  				kthread_stop(check_state->infos[i].thread);
>  			ret = -ENOMEM;
> @@ -2456,7 +2456,7 @@ int bch_btree_insert(struct cache_set *c, struct keylist *keys,
>  	if (ret) {
>  		struct bkey *k;
>  
> -		pr_err("error %i", ret);
> +		pr_err("error %i\n", ret);
>  
>  		while ((k = bch_keylist_pop(keys)))
>  			bkey_put(c, k);
> @@ -2744,7 +2744,7 @@ struct keybuf_key *bch_keybuf_next_rescan(struct cache_set *c,
>  			break;
>  
>  		if (bkey_cmp(&buf->last_scanned, end) >= 0) {
> -			pr_debug("scan finished");
> +			pr_debug("scan finished\n");
>  			break;
>  		}
>  
> diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
> index 8867100..9162af5 100644
> --- a/drivers/md/bcache/extents.c
> +++ b/drivers/md/bcache/extents.c
> @@ -130,18 +130,18 @@ static void bch_bkey_dump(struct btree_keys *keys, const struct bkey *k)
>  	char buf[80];
>  
>  	bch_extent_to_text(buf, sizeof(buf), k);
> -	pr_err(" %s", buf);
> +	pr_cont(" %s", buf);
>  
>  	for (j = 0; j < KEY_PTRS(k); j++) {
>  		size_t n = PTR_BUCKET_NR(b->c, k, j);
>  
> -		pr_err(" bucket %zu", n);
> +		pr_cont(" bucket %zu", n);
>  		if (n >= b->c->sb.first_bucket && n < b->c->sb.nbuckets)
> -			pr_err(" prio %i",
> -			       PTR_BUCKET(b->c, k, j)->prio);
> +			pr_cont(" prio %i",
> +				PTR_BUCKET(b->c, k, j)->prio);
>  	}
>  
> -	pr_err(" %s\n", bch_ptr_status(b->c, k));
> +	pr_cont(" %s\n", bch_ptr_status(b->c, k));
>  }
>  
>  /* Btree ptrs */
> @@ -553,7 +553,7 @@ static bool bch_extent_bad(struct btree_keys *bk, const struct bkey *k)
>  
>  		if (stale && KEY_DIRTY(k)) {
>  			bch_extent_to_text(buf, sizeof(buf), k);
> -			pr_info("stale dirty pointer, stale %u, key: %s",
> +			pr_info("stale dirty pointer, stale %u, key: %s\n",
>  				stale, buf);
>  		}
>  
> diff --git a/drivers/md/bcache/io.c b/drivers/md/bcache/io.c
> index 4d93f07..b25ee33 100644
> --- a/drivers/md/bcache/io.c
> +++ b/drivers/md/bcache/io.c
> @@ -65,14 +65,14 @@ void bch_count_backing_io_errors(struct cached_dev *dc, struct bio *bio)
>  	 * we shouldn't count failed REQ_RAHEAD bio to dc->io_errors.
>  	 */
>  	if (bio->bi_opf & REQ_RAHEAD) {
> -		pr_warn_ratelimited("%s: Read-ahead I/O failed on backing device, ignore",
> +		pr_warn_ratelimited("%s: Read-ahead I/O failed on backing device, ignore\n",
>  				    dc->backing_dev_name);
>  		return;
>  	}
>  
>  	errors = atomic_add_return(1, &dc->io_errors);
>  	if (errors < dc->error_limit)
> -		pr_err("%s: IO error on backing device, unrecoverable",
> +		pr_err("%s: IO error on backing device, unrecoverable\n",
>  			dc->backing_dev_name);
>  	else
>  		bch_cached_dev_error(dc);
> @@ -123,12 +123,12 @@ void bch_count_io_errors(struct cache *ca,
>  		errors >>= IO_ERROR_SHIFT;
>  
>  		if (errors < ca->set->error_limit)
> -			pr_err("%s: IO error on %s%s",
> +			pr_err("%s: IO error on %s%s\n",
>  			       ca->cache_dev_name, m,
>  			       is_read ? ", recovering." : ".");
>  		else
>  			bch_cache_set_error(ca->set,
> -					    "%s: too many IO errors %s",
> +					    "%s: too many IO errors %s\n",
>  					    ca->cache_dev_name, m);
>  	}
>  }
> diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
> index 0e3ff9..90aac4 100644
> --- a/drivers/md/bcache/journal.c
> +++ b/drivers/md/bcache/journal.c
> @@ -47,7 +47,7 @@ static int journal_read_bucket(struct cache *ca, struct list_head *list,
>  
>  	closure_init_stack(&cl);
>  
> -	pr_debug("reading %u", bucket_index);
> +	pr_debug("reading %u\n", bucket_index);
>  
>  	while (offset < ca->sb.bucket_size) {
>  reread:		left = ca->sb.bucket_size - offset;
> @@ -78,13 +78,13 @@ reread:		left = ca->sb.bucket_size - offset;
>  			size_t blocks, bytes = set_bytes(j);
>  
>  			if (j->magic != jset_magic(&ca->sb)) {
> -				pr_debug("%u: bad magic", bucket_index);
> +				pr_debug("%u: bad magic\n", bucket_index);
>  				return ret;
>  			}
>  
>  			if (bytes > left << 9 ||
>  			    bytes > PAGE_SIZE << JSET_BITS) {
> -				pr_info("%u: too big, %zu bytes, offset %u",
> +				pr_info("%u: too big, %zu bytes, offset %u\n",
>  					bucket_index, bytes, offset);
>  				return ret;
>  			}
> @@ -93,7 +93,7 @@ reread:		left = ca->sb.bucket_size - offset;
>  				goto reread;
>  
>  			if (j->csum != csum_set(j)) {
> -				pr_info("%u: bad csum, %zu bytes, offset %u",
> +				pr_info("%u: bad csum, %zu bytes, offset %u\n",
>  					bucket_index, bytes, offset);
>  				return ret;
>  			}
> @@ -190,7 +190,7 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
>  		uint64_t seq;
>  
>  		bitmap_zero(bitmap, SB_JOURNAL_BUCKETS);
> -		pr_debug("%u journal buckets", ca->sb.njournal_buckets);
> +		pr_debug("%u journal buckets\n", ca->sb.njournal_buckets);
>  
>  		/*
>  		 * Read journal buckets ordered by golden ratio hash to quickly
> @@ -215,7 +215,7 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
>  		 * If that fails, check all the buckets we haven't checked
>  		 * already
>  		 */
> -		pr_debug("falling back to linear search");
> +		pr_debug("falling back to linear search\n");
>  
>  		for (l = find_first_zero_bit(bitmap, ca->sb.njournal_buckets);
>  		     l < ca->sb.njournal_buckets;
> @@ -233,7 +233,7 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
>  		/* Binary search */
>  		m = l;
>  		r = find_next_bit(bitmap, ca->sb.njournal_buckets, l + 1);
> -		pr_debug("starting binary search, l %u r %u", l, r);
> +		pr_debug("starting binary search, l %u r %u\n", l, r);
>  
>  		while (l + 1 < r) {
>  			seq = list_entry(list->prev, struct journal_replay,
> @@ -253,7 +253,7 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
>  		 * Read buckets in reverse order until we stop finding more
>  		 * journal entries
>  		 */
> -		pr_debug("finishing up: m %u njournal_buckets %u",
> +		pr_debug("finishing up: m %u njournal_buckets %u\n",
>  			 m, ca->sb.njournal_buckets);
>  		l = m;
>  
> @@ -370,10 +370,10 @@ int bch_journal_replay(struct cache_set *s, struct list_head *list)
>  
>  		if (n != i->j.seq) {
>  			if (n == start && is_discard_enabled(s))
> -				pr_info("bcache: journal entries %llu-%llu may be discarded! (replaying %llu-%llu)",
> +				pr_info("journal entries %llu-%llu may be discarded! (replaying %llu-%llu)\n",
>  					n, i->j.seq - 1, start, end);
>  			else {
> -				pr_err("bcache: journal entries %llu-%llu missing! (replaying %llu-%llu)",
> +				pr_err("journal entries %llu-%llu missing! (replaying %llu-%llu)\n",
>  					n, i->j.seq - 1, start, end);
>  				ret = -EIO;
>  				goto err;
> @@ -403,7 +403,7 @@ int bch_journal_replay(struct cache_set *s, struct list_head *list)
>  		entries++;
>  	}
>  
> -	pr_info("journal replay done, %i keys in %i entries, seq %llu",
> +	pr_info("journal replay done, %i keys in %i entries, seq %llu\n",
>  		keys, entries, end);
>  err:
>  	while (!list_empty(list)) {
> @@ -481,7 +481,7 @@ static void btree_flush_write(struct cache_set *c)
>  			break;
>  
>  		if (btree_node_journal_flush(b))
> -			pr_err("BUG: flush_write bit should not be set here!");
> +			pr_err("BUG: flush_write bit should not be set here!\n");
>  
>  		mutex_lock(&b->write_lock);
>  
> @@ -534,13 +534,13 @@ static void btree_flush_write(struct cache_set *c)
>  	for (i = 0; i < nr; i++) {
>  		b = btree_nodes[i];
>  		if (!b) {
> -			pr_err("BUG: btree_nodes[%d] is NULL", i);
> +			pr_err("BUG: btree_nodes[%d] is NULL\n", i);
>  			continue;
>  		}
>  
>  		/* safe to check without holding b->write_lock */
>  		if (!btree_node_journal_flush(b)) {
> -			pr_err("BUG: bnode %p: journal_flush bit cleaned", b);
> +			pr_err("BUG: bnode %p: journal_flush bit cleaned\n", b);
>  			continue;
>  		}
>  
> @@ -548,14 +548,14 @@ static void btree_flush_write(struct cache_set *c)
>  		if (!btree_current_write(b)->journal) {
>  			clear_bit(BTREE_NODE_journal_flush, &b->flags);
>  			mutex_unlock(&b->write_lock);
> -			pr_debug("bnode %p: written by others", b);
> +			pr_debug("bnode %p: written by others\n", b);
>  			continue;
>  		}
>  
>  		if (!btree_node_dirty(b)) {
>  			clear_bit(BTREE_NODE_journal_flush, &b->flags);
>  			mutex_unlock(&b->write_lock);
> -			pr_debug("bnode %p: dirty bit cleaned by others", b);
> +			pr_debug("bnode %p: dirty bit cleaned by others\n", b);
>  			continue;
>  		}
>  
> @@ -716,7 +716,7 @@ void bch_journal_next(struct journal *j)
>  	j->cur->data->keys	= 0;
>  
>  	if (fifo_full(&j->pin))
> -		pr_debug("journal_pin full (%zu)", fifo_used(&j->pin));
> +		pr_debug("journal_pin full (%zu)\n", fifo_used(&j->pin));
>  }
>  
>  static void journal_write_endio(struct bio *bio)
> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index 71a90fb..94edb4 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -110,7 +110,7 @@ static void bch_data_invalidate(struct closure *cl)
>  	struct data_insert_op *op = container_of(cl, struct data_insert_op, cl);
>  	struct bio *bio = op->bio;
>  
> -	pr_debug("invalidating %i sectors from %llu",
> +	pr_debug("invalidating %i sectors from %llu\n",
>  		 bio_sectors(bio), (uint64_t) bio->bi_iter.bi_sector);
>  
>  	while (bio_sectors(bio)) {
> @@ -396,7 +396,7 @@ static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
>  
>  	if (bio->bi_iter.bi_sector & (c->sb.block_size - 1) ||
>  	    bio_sectors(bio) & (c->sb.block_size - 1)) {
> -		pr_debug("skipping unaligned io");
> +		pr_debug("skipping unaligned io\n");
>  		goto skip;
>  	}
>  
> @@ -650,7 +650,7 @@ static void backing_request_endio(struct bio *bio)
>  		 */
>  		if (unlikely(s->iop.writeback &&
>  			     bio->bi_opf & REQ_PREFLUSH)) {
> -			pr_err("Can't flush %s: returned bi_status %i",
> +			pr_err("Can't flush %s: returned bi_status %i\n",
>  				dc->backing_dev_name, bio->bi_status);
>  		} else {
>  			/* set to orig_bio->bi_status in bio_complete() */
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index d98354..467149f 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -89,7 +89,7 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
>  	for (i = 0; i < SB_JOURNAL_BUCKETS; i++)
>  		sb->d[i] = le64_to_cpu(s->d[i]);
>  
> -	pr_debug("read sb version %llu, flags %llu, seq %llu, journal size %u",
> +	pr_debug("read sb version %llu, flags %llu, seq %llu, journal size %u\n",
>  		 sb->version, sb->flags, sb->seq, sb->keys);
>  
>  	err = "Not a bcache superblock (bad offset)";
> @@ -234,7 +234,7 @@ static void __write_super(struct cache_sb *sb, struct cache_sb_disk *out,
>  
>  	out->csum = csum_set(out);
>  
> -	pr_debug("ver %llu, flags %llu, seq %llu",
> +	pr_debug("ver %llu, flags %llu, seq %llu\n",
>  		 sb->version, sb->flags, sb->seq);
>  
>  	submit_bio(bio);
> @@ -365,11 +365,11 @@ static void uuid_io(struct cache_set *c, int op, unsigned long op_flags,
>  	}
>  
>  	bch_extent_to_text(buf, sizeof(buf), k);
> -	pr_debug("%s UUIDs at %s", op == REQ_OP_WRITE ? "wrote" : "read", buf);
> +	pr_debug("%s UUIDs at %s\n", op == REQ_OP_WRITE ? "wrote" : "read", buf);
>  
>  	for (u = c->uuids; u < c->uuids + c->nr_uuids; u++)
>  		if (!bch_is_zero(u->uuid, 16))
> -			pr_debug("Slot %zi: %pU: %s: 1st: %u last: %u inv: %u",
> +			pr_debug("Slot %zi: %pU: %s: 1st: %u last: %u inv: %u\n",
>  				 u - c->uuids, u->uuid, u->label,
>  				 u->first_reg, u->last_reg, u->invalidated);
>  
> @@ -534,7 +534,7 @@ int bch_prio_write(struct cache *ca, bool wait)
>  	struct bucket *b;
>  	struct closure cl;
>  
> -	pr_debug("free_prio=%zu, free_none=%zu, free_inc=%zu",
> +	pr_debug("free_prio=%zu, free_none=%zu, free_inc=%zu\n",
>  		 fifo_used(&ca->free[RESERVE_PRIO]),
>  		 fifo_used(&ca->free[RESERVE_NONE]),
>  		 fifo_used(&ca->free_inc));
> @@ -629,12 +629,12 @@ static int prio_read(struct cache *ca, uint64_t bucket)
>  
>  			if (p->csum !=
>  			    bch_crc64(&p->magic, bucket_bytes(ca) - 8)) {
> -				pr_warn("bad csum reading priorities");
> +				pr_warn("bad csum reading priorities\n");
>  				goto out;
>  			}
>  
>  			if (p->magic != pset_magic(&ca->sb)) {
> -				pr_warn("bad magic reading priorities");
> +				pr_warn("bad magic reading priorities\n");
>  				goto out;
>  			}
>  
> @@ -728,11 +728,11 @@ static void bcache_device_link(struct bcache_device *d, struct cache_set *c,
>  
>  	ret = sysfs_create_link(&d->kobj, &c->kobj, "cache");
>  	if (ret < 0)
> -		pr_err("Couldn't create device -> cache set symlink");
> +		pr_err("Couldn't create device -> cache set symlink\n");
>  
>  	ret = sysfs_create_link(&c->kobj, &d->kobj, d->name);
>  	if (ret < 0)
> -		pr_err("Couldn't create cache set -> device symlink");
> +		pr_err("Couldn't create cache set -> device symlink\n");
>  
>  	clear_bit(BCACHE_DEV_UNLINK_DONE, &d->flags);
>  }
> @@ -789,9 +789,9 @@ static void bcache_device_free(struct bcache_device *d)
>  	lockdep_assert_held(&bch_register_lock);
>  
>  	if (disk)
> -		pr_info("%s stopped", disk->disk_name);
> +		pr_info("%s stopped\n", disk->disk_name);
>  	else
> -		pr_err("bcache device (NULL gendisk) stopped");
> +		pr_err("bcache device (NULL gendisk) stopped\n");
>  
>  	if (d->c)
>  		bcache_device_detach(d);
> @@ -830,7 +830,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
>  	d->nr_stripes = DIV_ROUND_UP_ULL(sectors, d->stripe_size);
>  
>  	if (!d->nr_stripes || d->nr_stripes > max_stripes) {
> -		pr_err("nr_stripes too large or invalid: %u (start sector beyond end of disk?)",
> +		pr_err("nr_stripes too large or invalid: %u (start sector beyond end of disk?)\n",
>  			(unsigned int)d->nr_stripes);
>  		return -ENOMEM;
>  	}
> @@ -928,11 +928,11 @@ static int cached_dev_status_update(void *arg)
>  			dc->offline_seconds = 0;
>  
>  		if (dc->offline_seconds >= BACKING_DEV_OFFLINE_TIMEOUT) {
> -			pr_err("%s: device offline for %d seconds",
> +			pr_err("%s: device offline for %d seconds\n",
>  			       dc->backing_dev_name,
>  			       BACKING_DEV_OFFLINE_TIMEOUT);
> -			pr_err("%s: disable I/O request due to backing "
> -			       "device offline", dc->disk.name);
> +			pr_err("%s: disable I/O request due to backing device offline\n",
> +			       dc->disk.name);
>  			dc->io_disable = true;
>  			/* let others know earlier that io_disable is true */
>  			smp_mb();
> @@ -959,7 +959,7 @@ int bch_cached_dev_run(struct cached_dev *dc)
>  	};
>  
>  	if (dc->io_disable) {
> -		pr_err("I/O disabled on cached dev %s",
> +		pr_err("I/O disabled on cached dev %s\n",
>  		       dc->backing_dev_name);
>  		kfree(env[1]);
>  		kfree(env[2]);
> @@ -971,7 +971,7 @@ int bch_cached_dev_run(struct cached_dev *dc)
>  		kfree(env[1]);
>  		kfree(env[2]);
>  		kfree(buf);
> -		pr_info("cached dev %s is running already",
> +		pr_info("cached dev %s is running already\n",
>  		       dc->backing_dev_name);
>  		return -EBUSY;
>  	}
> @@ -1001,16 +1001,14 @@ int bch_cached_dev_run(struct cached_dev *dc)
>  	if (sysfs_create_link(&d->kobj, &disk_to_dev(d->disk)->kobj, "dev") ||
>  	    sysfs_create_link(&disk_to_dev(d->disk)->kobj,
>  			      &d->kobj, "bcache")) {
> -		pr_err("Couldn't create bcache dev <-> disk sysfs symlinks");
> +		pr_err("Couldn't create bcache dev <-> disk sysfs symlinks\n");
>  		return -ENOMEM;
>  	}
>  
>  	dc->status_update_thread = kthread_run(cached_dev_status_update,
>  					       dc, "bcache_status_update");
>  	if (IS_ERR(dc->status_update_thread)) {
> -		pr_warn("failed to create bcache_status_update kthread, "
> -			"continue to run without monitoring backing "
> -			"device status");
> +		pr_warn("failed to create bcache_status_update kthread, continue to run without monitoring backing device status\n");
>  	}
>  
>  	return 0;
> @@ -1036,7 +1034,7 @@ static void cancel_writeback_rate_update_dwork(struct cached_dev *dc)
>  	} while (time_out > 0);
>  
>  	if (time_out == 0)
> -		pr_warn("give up waiting for dc->writeback_write_update to quit");
> +		pr_warn("give up waiting for dc->writeback_write_update to quit\n");
>  
>  	cancel_delayed_work_sync(&dc->writeback_rate_update);
>  }
> @@ -1077,7 +1075,7 @@ static void cached_dev_detach_finish(struct work_struct *w)
>  
>  	mutex_unlock(&bch_register_lock);
>  
> -	pr_info("Caching disabled for %s", dc->backing_dev_name);
> +	pr_info("Caching disabled for %s\n", dc->backing_dev_name);
>  
>  	/* Drop ref we took in cached_dev_detach() */
>  	closure_put(&dc->disk.cl);
> @@ -1117,20 +1115,20 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
>  		return -ENOENT;
>  
>  	if (dc->disk.c) {
> -		pr_err("Can't attach %s: already attached",
> +		pr_err("Can't attach %s: already attached\n",
>  		       dc->backing_dev_name);
>  		return -EINVAL;
>  	}
>  
>  	if (test_bit(CACHE_SET_STOPPING, &c->flags)) {
> -		pr_err("Can't attach %s: shutting down",
> +		pr_err("Can't attach %s: shutting down\n",
>  		       dc->backing_dev_name);
>  		return -EINVAL;
>  	}
>  
>  	if (dc->sb.block_size < c->sb.block_size) {
>  		/* Will die */
> -		pr_err("Couldn't attach %s: block size less than set's block size",
> +		pr_err("Couldn't attach %s: block size less than set's block size\n",
>  		       dc->backing_dev_name);
>  		return -EINVAL;
>  	}
> @@ -1138,7 +1136,7 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
>  	/* Check whether already attached */
>  	list_for_each_entry_safe(exist_dc, t, &c->cached_devs, list) {
>  		if (!memcmp(dc->sb.uuid, exist_dc->sb.uuid, 16)) {
> -			pr_err("Tried to attach %s but duplicate UUID already attached",
> +			pr_err("Tried to attach %s but duplicate UUID already attached\n",
>  				dc->backing_dev_name);
>  
>  			return -EINVAL;
> @@ -1157,14 +1155,14 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
>  
>  	if (!u) {
>  		if (BDEV_STATE(&dc->sb) == BDEV_STATE_DIRTY) {
> -			pr_err("Couldn't find uuid for %s in set",
> +			pr_err("Couldn't find uuid for %s in set\n",
>  			       dc->backing_dev_name);
>  			return -ENOENT;
>  		}
>  
>  		u = uuid_find_empty(c);
>  		if (!u) {
> -			pr_err("Not caching %s, no room for UUID",
> +			pr_err("Not caching %s, no room for UUID\n",
>  			       dc->backing_dev_name);
>  			return -EINVAL;
>  		}
> @@ -1210,7 +1208,7 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
>  	down_write(&dc->writeback_lock);
>  	if (bch_cached_dev_writeback_start(dc)) {
>  		up_write(&dc->writeback_lock);
> -		pr_err("Couldn't start writeback facilities for %s",
> +		pr_err("Couldn't start writeback facilities for %s\n",
>  		       dc->disk.disk->disk_name);
>  		return -ENOMEM;
>  	}
> @@ -1233,7 +1231,7 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
>  		 */
>  		kthread_stop(dc->writeback_thread);
>  		cancel_writeback_rate_update_dwork(dc);
> -		pr_err("Couldn't run cached device %s",
> +		pr_err("Couldn't run cached device %s\n",
>  		       dc->backing_dev_name);
>  		return ret;
>  	}
> @@ -1244,7 +1242,7 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
>  	/* Allow the writeback thread to proceed */
>  	up_write(&dc->writeback_lock);
>  
> -	pr_info("Caching %s as %s on set %pU",
> +	pr_info("Caching %s as %s on set %pU\n",
>  		dc->backing_dev_name,
>  		dc->disk.disk->disk_name,
>  		dc->disk.c->sb.set_uuid);
> @@ -1384,7 +1382,7 @@ static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
>  	if (bch_cache_accounting_add_kobjs(&dc->accounting, &dc->disk.kobj))
>  		goto err;
>  
> -	pr_info("registered backing device %s", dc->backing_dev_name);
> +	pr_info("registered backing device %s\n", dc->backing_dev_name);
>  
>  	list_add(&dc->list, &uncached_devices);
>  	/* attach to a matched cache set if it exists */
> @@ -1401,7 +1399,7 @@ static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
>  
>  	return 0;
>  err:
> -	pr_notice("error %s: %s", dc->backing_dev_name, err);
> +	pr_notice("error %s: %s\n", dc->backing_dev_name, err);
>  	bcache_device_stop(&dc->disk);
>  	return ret;
>  }
> @@ -1497,7 +1495,7 @@ int bch_flash_dev_create(struct cache_set *c, uint64_t size)
>  
>  	u = uuid_find_empty(c);
>  	if (!u) {
> -		pr_err("Can't create volume, no room for UUID");
> +		pr_err("Can't create volume, no room for UUID\n");
>  		return -EINVAL;
>  	}
>  
> @@ -1523,7 +1521,7 @@ bool bch_cached_dev_error(struct cached_dev *dc)
>  	smp_mb();
>  
>  	pr_err("stop %s: too many IO errors on backing device %s\n",
> -		dc->disk.disk->disk_name, dc->backing_dev_name);
> +	       dc->disk.disk->disk_name, dc->backing_dev_name);
>  
>  	bcache_device_stop(&dc->disk);
>  	return true;
> @@ -1534,6 +1532,7 @@ bool bch_cached_dev_error(struct cached_dev *dc)
>  __printf(2, 3)
>  bool bch_cache_set_error(struct cache_set *c, const char *fmt, ...)
>  {
> +	struct va_format vaf;
>  	va_list args;
>  
>  	if (c->on_error != ON_ERROR_PANIC &&
> @@ -1541,20 +1540,22 @@ bool bch_cache_set_error(struct cache_set *c, const char *fmt, ...)
>  		return false;
>  
>  	if (test_and_set_bit(CACHE_SET_IO_DISABLE, &c->flags))
> -		pr_info("CACHE_SET_IO_DISABLE already set");
> +		pr_info("CACHE_SET_IO_DISABLE already set\n");
>  
>  	/*
>  	 * XXX: we can be called from atomic context
>  	 * acquire_console_sem();
>  	 */
>  
> -	pr_err("bcache: error on %pU: ", c->sb.set_uuid);
> -
>  	va_start(args, fmt);
> -	vprintk(fmt, args);
> -	va_end(args);
>  
> -	pr_err(", disabling caching\n");
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
> +
> +	pr_err("error on %pU: %pV, disabling caching\n",
> +	       c->sb.set_uuid, &vaf);
> +
> +	va_end(args);
>  
>  	if (c->on_error == ON_ERROR_PANIC)
>  		panic("panic forced after error\n");
> @@ -1606,7 +1607,7 @@ static void cache_set_free(struct closure *cl)
>  	list_del(&c->list);
>  	mutex_unlock(&bch_register_lock);
>  
> -	pr_info("Cache set %pU unregistered", c->sb.set_uuid);
> +	pr_info("Cache set %pU unregistered\n", c->sb.set_uuid);
>  	wake_up(&unregister_wait);
>  
>  	closure_debug_destroy(&c->cl);
> @@ -1677,7 +1678,7 @@ static void conditional_stop_bcache_device(struct cache_set *c,
>  					   struct cached_dev *dc)
>  {
>  	if (dc->stop_when_cache_set_failed == BCH_CACHED_DEV_STOP_ALWAYS) {
> -		pr_warn("stop_when_cache_set_failed of %s is \"always\", stop it for failed cache set %pU.",
> +		pr_warn("stop_when_cache_set_failed of %s is \"always\", stop it for failed cache set %pU.\n",
>  			d->disk->disk_name, c->sb.set_uuid);
>  		bcache_device_stop(d);
>  	} else if (atomic_read(&dc->has_dirty)) {
> @@ -1685,7 +1686,7 @@ static void conditional_stop_bcache_device(struct cache_set *c,
>  		 * dc->stop_when_cache_set_failed == BCH_CACHED_STOP_AUTO
>  		 * and dc->has_dirty == 1
>  		 */
> -		pr_warn("stop_when_cache_set_failed of %s is \"auto\" and cache is dirty, stop it to avoid potential data corruption.",
> +		pr_warn("stop_when_cache_set_failed of %s is \"auto\" and cache is dirty, stop it to avoid potential data corruption.\n",
>  			d->disk->disk_name);
>  		/*
>  		 * There might be a small time gap that cache set is
> @@ -1707,7 +1708,7 @@ static void conditional_stop_bcache_device(struct cache_set *c,
>  		 * dc->stop_when_cache_set_failed == BCH_CACHED_STOP_AUTO
>  		 * and dc->has_dirty == 0
>  		 */
> -		pr_warn("stop_when_cache_set_failed of %s is \"auto\" and cache is clean, keep it alive.",
> +		pr_warn("stop_when_cache_set_failed of %s is \"auto\" and cache is clean, keep it alive.\n",
>  			d->disk->disk_name);
>  	}
>  }
> @@ -1874,7 +1875,7 @@ static int run_cache_set(struct cache_set *c)
>  		if (bch_journal_read(c, &journal))
>  			goto err;
>  
> -		pr_debug("btree_journal_read() done");
> +		pr_debug("btree_journal_read() done\n");
>  
>  		err = "no journal entries found";
>  		if (list_empty(&journal))
> @@ -1920,7 +1921,7 @@ static int run_cache_set(struct cache_set *c)
>  
>  		bch_journal_mark(c, &journal);
>  		bch_initial_gc_finish(c);
> -		pr_debug("btree_check() done");
> +		pr_debug("btree_check() done\n");
>  
>  		/*
>  		 * bcache_journal_next() can't happen sooner, or
> @@ -1951,7 +1952,7 @@ static int run_cache_set(struct cache_set *c)
>  		if (bch_journal_replay(c, &journal))
>  			goto err;
>  	} else {
> -		pr_notice("invalidating existing data");
> +		pr_notice("invalidating existing data\n");
>  
>  		for_each_cache(ca, c, i) {
>  			unsigned int j;
> @@ -2085,7 +2086,7 @@ static const char *register_cache_set(struct cache *ca)
>  		memcpy(c->sb.set_uuid, ca->sb.set_uuid, 16);
>  		c->sb.flags             = ca->sb.flags;
>  		c->sb.seq		= ca->sb.seq;
> -		pr_debug("set version = %llu", c->sb.version);
> +		pr_debug("set version = %llu\n", c->sb.version);
>  	}
>  
>  	kobject_get(&ca->kobj);
> @@ -2247,7 +2248,7 @@ static int cache_alloc(struct cache *ca)
>  err_free:
>  	module_put(THIS_MODULE);
>  	if (err)
> -		pr_notice("error %s: %s", ca->cache_dev_name, err);
> +		pr_notice("error %s: %s\n", ca->cache_dev_name, err);
>  	return ret;
>  }
>  
> @@ -2301,14 +2302,14 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
>  		goto out;
>  	}
>  
> -	pr_info("registered cache device %s", ca->cache_dev_name);
> +	pr_info("registered cache device %s\n", ca->cache_dev_name);
>  
>  out:
>  	kobject_put(&ca->kobj);
>  
>  err:
>  	if (err)
> -		pr_notice("error %s: %s", ca->cache_dev_name, err);
> +		pr_notice("error %s: %s\n", ca->cache_dev_name, err);
>  
>  	return ret;
>  }
> @@ -2461,7 +2462,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>  out_module_put:
>  	module_put(THIS_MODULE);
>  out:
> -	pr_info("error %s: %s", path?path:"", err);
> +	pr_info("error %s: %s\n", path?path:"", err);
>  	return ret;
>  }
>  
> @@ -2506,7 +2507,7 @@ static ssize_t bch_pending_bdevs_cleanup(struct kobject *k,
>  	mutex_unlock(&bch_register_lock);
>  
>  	list_for_each_entry_safe(pdev, tpdev, &pending_devs, list) {
> -		pr_info("delete pdev %p", pdev);
> +		pr_info("delete pdev %p\n", pdev);
>  		list_del(&pdev->list);
>  		bcache_device_stop(&pdev->dc->disk);
>  		kfree(pdev);
> @@ -2549,7 +2550,7 @@ static int bcache_reboot(struct notifier_block *n, unsigned long code, void *x)
>  
>  		mutex_unlock(&bch_register_lock);
>  
> -		pr_info("Stopping all devices:");
> +		pr_info("Stopping all devices:\n");
>  
>  		/*
>  		 * The reason bch_register_lock is not held to call
> @@ -2599,9 +2600,9 @@ static int bcache_reboot(struct notifier_block *n, unsigned long code, void *x)
>  		finish_wait(&unregister_wait, &wait);
>  
>  		if (stopped)
> -			pr_info("All devices stopped");
> +			pr_info("All devices stopped\n");
>  		else
> -			pr_notice("Timeout waiting for devices to be closed");
> +			pr_notice("Timeout waiting for devices to be closed\n");
>  out:
>  		mutex_unlock(&bch_register_lock);
>  	}
> @@ -2637,7 +2638,7 @@ static void check_module_parameters(void)
>  	if (bch_cutoff_writeback_sync == 0)
>  		bch_cutoff_writeback_sync = CUTOFF_WRITEBACK_SYNC;
>  	else if (bch_cutoff_writeback_sync > CUTOFF_WRITEBACK_SYNC_MAX) {
> -		pr_warn("set bch_cutoff_writeback_sync (%u) to max value %u",
> +		pr_warn("set bch_cutoff_writeback_sync (%u) to max value %u\n",
>  			bch_cutoff_writeback_sync, CUTOFF_WRITEBACK_SYNC_MAX);
>  		bch_cutoff_writeback_sync = CUTOFF_WRITEBACK_SYNC_MAX;
>  	}
> @@ -2645,13 +2646,13 @@ static void check_module_parameters(void)
>  	if (bch_cutoff_writeback == 0)
>  		bch_cutoff_writeback = CUTOFF_WRITEBACK;
>  	else if (bch_cutoff_writeback > CUTOFF_WRITEBACK_MAX) {
> -		pr_warn("set bch_cutoff_writeback (%u) to max value %u",
> +		pr_warn("set bch_cutoff_writeback (%u) to max value %u\n",
>  			bch_cutoff_writeback, CUTOFF_WRITEBACK_MAX);
>  		bch_cutoff_writeback = CUTOFF_WRITEBACK_MAX;
>  	}
>  
>  	if (bch_cutoff_writeback > bch_cutoff_writeback_sync) {
> -		pr_warn("set bch_cutoff_writeback (%u) to %u",
> +		pr_warn("set bch_cutoff_writeback (%u) to %u\n",
>  			bch_cutoff_writeback, bch_cutoff_writeback_sync);
>  		bch_cutoff_writeback = bch_cutoff_writeback_sync;
>  	}
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index 323276..0dadec5 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -421,7 +421,7 @@ STORE(__cached_dev)
>  				return size;
>  		}
>  		if (v == -ENOENT)
> -			pr_err("Can't attach %s: cache set not found", buf);
> +			pr_err("Can't attach %s: cache set not found\n", buf);
>  		return v;
>  	}
>  
> @@ -455,7 +455,7 @@ STORE(bch_cached_dev)
>  			 */
>  			if (dc->writeback_running) {
>  				dc->writeback_running = false;
> -				pr_err("%s: failed to run non-existent writeback thread",
> +				pr_err("%s: failed to run non-existent writeback thread\n",
>  						dc->disk.disk->disk_name);
>  			}
>  		} else
> @@ -872,11 +872,11 @@ STORE(__bch_cache_set)
>  		if (v) {
>  			if (test_and_set_bit(CACHE_SET_IO_DISABLE,
>  					     &c->flags))
> -				pr_warn("CACHE_SET_IO_DISABLE already set");
> +				pr_warn("CACHE_SET_IO_DISABLE already set\n");
>  		} else {
>  			if (!test_and_clear_bit(CACHE_SET_IO_DISABLE,
>  						&c->flags))
> -				pr_warn("CACHE_SET_IO_DISABLE already cleared");
> +				pr_warn("CACHE_SET_IO_DISABLE already cleared\n");
>  		}
>  	}
>  
> diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
> index 3f7641..1cf1e5 100644
> --- a/drivers/md/bcache/writeback.c
> +++ b/drivers/md/bcache/writeback.c
> @@ -809,7 +809,7 @@ static int bch_root_node_dirty_init(struct cache_set *c,
>  			schedule_timeout_interruptible(
>  				msecs_to_jiffies(INIT_KEYS_SLEEP_MS));
>  		else if (ret < 0) {
> -			pr_warn("sectors dirty init failed, ret=%d!", ret);
> +			pr_warn("sectors dirty init failed, ret=%d!\n", ret);
>  			break;
>  		}
>  	} while (ret == -EAGAIN);
> @@ -917,7 +917,7 @@ void bch_sectors_dirty_init(struct bcache_device *d)
>  
>  	state = kzalloc(sizeof(struct bch_dirty_init_state), GFP_KERNEL);
>  	if (!state) {
> -		pr_warn("sectors dirty init failed: cannot allocate memory");
> +		pr_warn("sectors dirty init failed: cannot allocate memory\n");
>  		return;
>  	}
>  
> @@ -945,7 +945,7 @@ void bch_sectors_dirty_init(struct bcache_device *d)
>  				    &state->infos[i],
>  				    name);
>  		if (IS_ERR(state->infos[i].thread)) {
> -			pr_err("fails to run thread bch_dirty_init[%d]", i);
> +			pr_err("fails to run thread bch_dirty_init[%d]\n", i);
>  			for (--i; i >= 0; i--)
>  				kthread_stop(state->infos[i].thread);
>  			goto out;
> 
