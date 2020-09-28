Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F2E27A785
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgI1GXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:23:15 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55307 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1GXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:23:14 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200928062313euoutp0209e66d4ffc15f161241cc25f743d9b71~43mUIYvFb2629426294euoutp02w
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 06:23:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200928062313euoutp0209e66d4ffc15f161241cc25f743d9b71~43mUIYvFb2629426294euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601274193;
        bh=sMRoNvoNCckLetnkOEObE4iSvh+Cw4XnyVpKhTsB7Lg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NqHmLpPPFKOb2j07SnGZv4vmyEe8oBXrdeH+60a0QSZEpAIuEo4VGr6DjvUNIlDcl
         SMh6EFCYRIMrzyD89ooefb7tsCo5AKijGNa03KfMsQI2dvRLqEcD931jPHhR6v+9jt
         IacAVqllFyp83YtJzEqjacwj/dxfFNQNegwACXiw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200928062312eucas1p17128f82f5140449e9f492f675affd150~43mT0G87a1648516485eucas1p1-;
        Mon, 28 Sep 2020 06:23:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A4.57.05997.051817F5; Mon, 28
        Sep 2020 07:23:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200928062312eucas1p2dc96e9354d31296b107939b3533fbbfd~43mTixO8t2823328233eucas1p2j;
        Mon, 28 Sep 2020 06:23:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200928062312eusmtrp101ab089e07c9d0730273ff40b6d2f05f~43mTiGhAO1456014560eusmtrp17;
        Mon, 28 Sep 2020 06:23:12 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-42-5f7181507dda
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4F.DA.06314.051817F5; Mon, 28
        Sep 2020 07:23:12 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200928062311eusmtip2cf8a2a6f4a2ae12e7295e551cd9bce52~43mTA-Huy2499424994eusmtip2A;
        Mon, 28 Sep 2020 06:23:11 +0000 (GMT)
Subject: Re: [PATCH next 1/2] printk: avoid and/or handle record truncation
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a27f6e69-90fc-c824-ee76-19a69a5bd1b0@samsung.com>
Date:   Mon, 28 Sep 2020 08:23:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200926015526.8921-2-john.ogness@linutronix.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djP87oBjYXxBrsfalg0L17PZrHtynxG
        i8u75rBZ/H/8ldViX8cDJotHEyYxWaz9/JjdYvOmqcwWj/resjtweuycdZfdo2XfLXaPd+fO
        sXucmPGbxWP/3DXsHuu3XGXx+LxJLoA9issmJTUnsyy1SN8ugSvj5vGVTAVLtCpmvVzJ1sD4
        RbGLkZNDQsBEYvPxV2wgtpDACkaJZyeUuhi5gOwvjBJ/Zvxig3A+M0q8Pn+fHabjx9c+FojE
        ckaJrU0LmCHa3zNKXPoJNkpYwFvix72dYA0iQPaq13vZQRqYBQ4wSZz8sosJJMEmYCjR9bYL
        rIFXwE5ifdscsDiLgKpE8/ZlYM2iAnESx049YoGoEZQ4OfMJmM0JVH/sxVSwGmYBeYntb+cw
        Q9jiEreezGcCWSYhcIpd4u+Wa0ANHECOi8TBXV4QHwhLvDq+BeobGYnTk3tYIOqbGSUenlvL
        DuH0MEpcbprBCFFlLXHnHCgwOIA2aEqs36UPEXaUaHw3hRViPp/EjbeCEDfwSUzaNp0ZIswr
        0dEmBFGtJjHr+Dq4tQcvXGKewKg0C8lns5B8MwvJN7MQ9i5gZFnFKJ5aWpybnlpslJdarlec
        mFtcmpeul5yfu4kRmKpO/zv+ZQfjrj9JhxgFOBiVeHgjdhbEC7EmlhVX5h5ilOBgVhLhdTp7
        Ok6INyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYOTqkGRocVlmXi
        M+dOzH770vnjHvU3rGk5DSrdN15PWHgm9hbnjfgqzXSmz/8OiyYkPZFeY11qanV8nvaCxAkZ
        v44eS3l3uf2Rrq2al0vcot1PslPzIzmqnsgVVVuZN29yi1g471+E8+G9JxW2sD5KY4jrPNx2
        aoFjXPN1qfMc6ytMVeyPbmIo6D3Lo8RSnJFoqMVcVJwIACwMoGNRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7oBjYXxBtMeilo0L17PZrHtynxG
        i8u75rBZ/H/8ldViX8cDJotHEyYxWaz9/JjdYvOmqcwWj/resjtweuycdZfdo2XfLXaPd+fO
        sXucmPGbxWP/3DXsHuu3XGXx+LxJLoA9Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DY
        PNbKyFRJ384mJTUnsyy1SN8uQS/j5vGVTAVLtCpmvVzJ1sD4RbGLkZNDQsBE4sfXPhYQW0hg
        KaPEqQ4XiLiMxMlpDawQtrDEn2tdbF2MXEA1bxklOq93gDUIC3hL/Li3kx3EFgGyV73eyw5S
        xCxwiEni6r+tLBAdRxkl9r1dxwRSxSZgKNH1FmQUJwevgJ3E+rY5YHEWAVWJ5u3LwCaJCsRJ
        nOl5AVUjKHFy5hOwbZxA9cdeTAWrYRYwk5i3+SEzhC0vsf3tHChbXOLWk/lMExiFZiFpn4Wk
        ZRaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjM9tx35u3sF4aWPwIUYBDkYl
        Ht6InQXxQqyJZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGDq
        yCuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwBhyyCZzbuPqKYxT
        xeZust/wcfLk8kbHf3pFC666KjRtOOpruLuv1v4N2+1floY7GUOLeZ/c23M1/Vqq0IYWeTHX
        dN0FUwzaeEL+HCr0sJHuFVT79XtBne96znNz5D1PmsRI/V5e/UppUeW16JZrGYdXixztS4uq
        7WE92b/U+FVl9fXXTVKGDkosxRmJhlrMRcWJAM2Mi3jlAgAA
X-CMS-MailID: 20200928062312eucas1p2dc96e9354d31296b107939b3533fbbfd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200926015533eucas1p2c3e5ccd1cfb70d82c33a2ee64b617710
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200926015533eucas1p2c3e5ccd1cfb70d82c33a2ee64b617710
References: <20200926015526.8921-1-john.ogness@linutronix.de>
        <CGME20200926015533eucas1p2c3e5ccd1cfb70d82c33a2ee64b617710@eucas1p2.samsung.com>
        <20200926015526.8921-2-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 26.09.2020 03:55, John Ogness wrote:
> If a reader provides a buffer that is smaller than the message text,
> the @text_len field of @info will have a value larger than the buffer
> size. If readers blindly read @text_len bytes of data without
> checking the size, they will read beyond their buffer.
>
> Add this check to record_print_text() to properly recognize when such
> truncation needs to occur.
>
> Add a maximum size argument to the ringbuffer function to extend
> records so that records can not be created that are larger than the
> buffer size of readers.
>
> When extending records (LOG_CONT), do not extend records beyond
> LOG_LINE_MAX since that is the maximum size available in the buffers
> used by consoles and syslog.
>
> Fixes: f5f022e53b87 ("printk: reimplement log_cont using record extension")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for fixing this issue!

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   kernel/printk/printk.c            |  7 ++++++-
>   kernel/printk/printk_ringbuffer.c | 12 ++++++++++--
>   kernel/printk/printk_ringbuffer.h |  2 +-
>   3 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 78f68b4830dc..270f19b60e6f 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1357,6 +1357,11 @@ static size_t record_print_text(struct printk_record *r, bool syslog,
>   	size_t len = 0;
>   	char *next;
>   
> +	if (text_len > buf_size) {
> +		text_len = buf_size;
> +		truncated = true;
> +	}
> +
>   	prefix_len = info_print_prefix(r->info, syslog, time, prefix);
>   
>   	/*
> @@ -1911,7 +1916,7 @@ static size_t log_output(int facility, int level, enum log_flags lflags,
>   		struct printk_record r;
>   
>   		prb_rec_init_wr(&r, text_len);
> -		if (prb_reserve_in_last(&e, prb, &r, caller_id)) {
> +		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
>   			memcpy(&r.text_buf[r.info->text_len], text, text_len);
>   			r.info->text_len += text_len;
>   			if (lflags & LOG_NEWLINE) {
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 13b94b92342e..2493348a1631 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -202,7 +202,8 @@
>    *	// specify additional 5 bytes text space to extend
>    *	prb_rec_init_wr(&r, 5);
>    *
> - *	if (prb_reserve_in_last(&e, &test_rb, &r, printk_caller_id())) {
> + *	// try to extend, but only if it does not exceed 32 bytes
> + *	if (prb_reserve_in_last(&e, &test_rb, &r, printk_caller_id()), 32) {
>    *		snprintf(&r.text_buf[r.info->text_len],
>    *			 r.text_buf_size - r.info->text_len, "hello");
>    *
> @@ -1309,6 +1310,7 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
>    * @rb:        The ringbuffer to re-reserve and extend data in.
>    * @r:         The record structure to allocate buffers for.
>    * @caller_id: The caller ID of the caller (reserving writer).
> + * @max_size:  Fail if the extended size would be greater than this.
>    *
>    * This is the public function available to writers to re-reserve and extend
>    * data.
> @@ -1343,7 +1345,7 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
>    *            @r->info->text_len after concatenating.
>    */
>   bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
> -			 struct printk_record *r, u32 caller_id)
> +			 struct printk_record *r, u32 caller_id, unsigned int max_size)
>   {
>   	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>   	struct printk_info *info;
> @@ -1389,6 +1391,9 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
>   		if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
>   			goto fail;
>   
> +		if (r->text_buf_size > max_size)
> +			goto fail;
> +
>   		r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
>   					 &d->text_blk_lpos, id);
>   	} else {
> @@ -1410,6 +1415,9 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
>   		if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
>   			goto fail;
>   
> +		if (r->text_buf_size > max_size)
> +			goto fail;
> +
>   		r->text_buf = data_realloc(rb, &rb->text_data_ring, r->text_buf_size,
>   					   &d->text_blk_lpos, id);
>   	}
> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> index 0adaa685d1ca..5dc9d022db07 100644
> --- a/kernel/printk/printk_ringbuffer.h
> +++ b/kernel/printk/printk_ringbuffer.h
> @@ -303,7 +303,7 @@ static inline void prb_rec_init_wr(struct printk_record *r,
>   bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
>   		 struct printk_record *r);
>   bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
> -			 struct printk_record *r, u32 caller_id);
> +			 struct printk_record *r, u32 caller_id, unsigned int max_size);
>   void prb_commit(struct prb_reserved_entry *e);
>   void prb_final_commit(struct prb_reserved_entry *e);
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

