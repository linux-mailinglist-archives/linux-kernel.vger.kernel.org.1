Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35852FBD20
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390982AbhASRCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbhASRBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:01:21 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5B0C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:00:41 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id e17so5056315qto.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=08oR5ePKYgmnwUMmiLW3tz0XD53PWw3uZbGRzawOCH0=;
        b=1e/gcV+jAqcthVzHr6yKibOb206aNyj01G2lTxdMnairjICxqUb7F+ykvckU6iJog7
         UODCTD0bHtjP/kM1+lkgOj8S5/6RX8zAd4RonEcGObwVXpvQwlnZmF8aLytmC5HFbnvl
         EtlYSZLyVuwEmN2T8kaPEnh9WlP8Qn7G+sUisFmHnzqLjly+Qn0ccs3DrKqsZQB87V5B
         TGcWng2PQNs9y7c0CelsY9hO1Xp+/znVgXw0zyvcRgh5bB8u69uJbpEIAv8hJix3wPdN
         QS6W+m7GyPt4qBCIXvbTSxc/0c1jWx1ie7p4nI8X5Pwda8GQEqX1T44ub0lRoo/V4I2v
         QCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=08oR5ePKYgmnwUMmiLW3tz0XD53PWw3uZbGRzawOCH0=;
        b=M3Ohr7g+uu43qAGSuODMaAh7PMJJ8Eu9WeoWcpweoLYWiiVbp1cRjo1lKraocdGhQK
         ZbU+spEKrrJxouyht/Di5npyIanQS7zQ3OAS4+VhP2QRIJxGkJ7w40gLm494JkkqLjRa
         2ft1IUJ4Gc2e/WNdu2iv6V/uK1grliS18Blvare1nY3lXsmz0Ts8eZ5DbdDRQ21+xFGt
         nDfefMkV1ZvbRMDjRqrgTOXHWHK8GPCyr2fjk07rFDO1lqLo0dK5n3Rb9vyJi2uRBEaO
         AGXOPDJshIYhO1xSI9Se5SXBVzkDcH/yjCO8p4Wv/bdd7auLBmNvJKBp6gYFAvkJN1+8
         v7IQ==
X-Gm-Message-State: AOAM532xMinArQ8m6s6euUKKm0Cmu7yRN8LGLuDxkpT0xlTwYS1D0qgS
        Epqchrp+MVVSqoedrf6XuMuz7Q==
X-Google-Smtp-Source: ABdhPJwG5qVDddc/+jIaMXA2P/4YTTV/Di5QpmE94tL/+G9HhfuYNS7pUAsadGjLuyfZVH76fZrwug==
X-Received: by 2002:ac8:bc4:: with SMTP id p4mr5027979qti.195.1611075640557;
        Tue, 19 Jan 2021 09:00:40 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id z26sm13255427qki.40.2021.01.19.09.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 09:00:39 -0800 (PST)
Date:   Tue, 19 Jan 2021 12:00:38 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: page_counter: relayout structure to reduce false
 sharing
Message-ID: <YAcQNuT0fnd9w1sC@cmpxchg.org>
References: <1611040814-33449-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1611040814-33449-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 03:20:14PM +0800, Feng Tang wrote:
> When checking a memory cgroup related performance regression [1],
> from the perf c2c profiling data, we found high false sharing for
> accessing 'usage' and 'parent'.
> 
> On 64 bit system, the 'usage' and 'parent' are close to each other,
> and easy to be in one cacheline (for cacheline size == 64+ B). 'usage'
> is usally written, while 'parent' is usually read as the cgroup's
> hierarchical counting nature.
> 
> So move the 'parent' to the end of the structure to make sure they
> are in different cache lines.
> 
> Following are some performance data with the patch, against
> v5.11-rc1. [ In the data, A means a platform with 2 sockets 48C/96T,
> B is a platform of 4 sockests 72C/144T, and if a %stddev will be
> shown bigger than 2%, P100/P50 means number of test tasks equals
> to 100%/50% of nr_cpu]
> 
> will-it-scale/malloc1
> ---------------------
> 	   v5.11-rc1			v5.11-rc1+patch
> 
> A-P100	     15782 ±  2%      -0.1%      15765 ±  3%  will-it-scale.per_process_ops
> A-P50	     21511            +8.9%      23432        will-it-scale.per_process_ops
> B-P100	      9155            +2.2%       9357        will-it-scale.per_process_ops
> B-P50	     10967            +7.1%      11751 ±  2%  will-it-scale.per_process_ops
> 
> will-it-scale/pagefault2
> ------------------------
> 	   v5.11-rc1			v5.11-rc1+patch
> 
> A-P100	     79028            +3.0%      81411        will-it-scale.per_process_ops
> A-P50	    183960 ±  2%      +4.4%     192078 ±  2%  will-it-scale.per_process_ops
> B-P100	     85966            +9.9%      94467 ±  3%  will-it-scale.per_process_ops
> B-P50	    198195            +9.8%     217526        will-it-scale.per_process_ops
> 
> fio (4k/1M is block size)
> -------------------------
> 	   v5.11-rc1			v5.11-rc1+patch
> 
> A-P50-r-4k     16881 ±  2%    +1.2%      17081 ±  2%  fio.read_bw_MBps
> A-P50-w-4k      3931          +4.5%       4111 ±  2%  fio.write_bw_MBps
> A-P50-r-1M     15178          -0.2%      15154        fio.read_bw_MBps
> A-P50-w-1M      3924          +0.1%       3929        fio.write_bw_MBps
> 
> [1].https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Reviewed-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!
