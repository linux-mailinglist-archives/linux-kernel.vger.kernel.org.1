Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE16B25FC7C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 17:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgIGPAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 11:00:45 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:2715 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730056AbgIGOxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:53:39 -0400
Subject: Re: [PATCH v7 3/3] binder: add transaction latency tracer
To:     Frankie Chang <Frankie.Chang@mediatek.com>,
        Todd Kjos <tkjos@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
References: <1596509145.5207.21.camel@mtkswgap22>
 <1596549552-5466-1-git-send-email-Frankie.Chang@mediatek.com>
 <1596549552-5466-4-git-send-email-Frankie.Chang@mediatek.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <f8ff8cb2-913d-c009-53a4-2918ce923a89@sony.com>
Date:   Mon, 7 Sep 2020 16:41:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596549552-5466-4-git-send-email-Frankie.Chang@mediatek.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=FfdJO626 c=1 sm=1 tr=0 a=CGteIMthFL3x4Fb36c5kWA==:117 a=IkcTkHD0fZMA:10 a=reM5J-MqmosA:10 a=9zETfiKQeoRBRZLemOoA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/20 3:59 PM, Frankie Chang wrote:
> +void probe_binder_txn_latency_free(void *ignore, struct binder_transaction *t,
> +					int from_proc, int from_thread,
> +					int to_proc, int to_thread)
> +{
> +	struct rtc_time tm;
> +	struct timespec64 *startime;
> +	struct timespec64 cur, sub_t;
> +
> +	ktime_get_ts64(&cur);


I think sched_clock is what you want.


> +	startime = &t->timestamp;
> +	sub_t = timespec64_sub(cur, *startime);
> +
> +	/* if transaction time is over than binder_txn_latency_threshold (sec),
> +	 * show timeout warning log.
> +	 */
> +	if (sub_t.tv_sec < binder_txn_latency_threshold)
> +		return;
> +
> +	rtc_time_to_tm(t->tv.tv_sec, &tm);

