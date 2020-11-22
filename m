Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCD72BC496
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 10:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgKVIwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 03:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgKVIwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 03:52:08 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D22C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 00:52:08 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id t37so11303059pga.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 00:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tuVn607FQC2Z7JxZDC4QieVMCILWTqSRSd3FAkHzFIQ=;
        b=J6fV/m9YDRZUBzYLxW/eRBYiaxabgyrliYLl+hkVoGnt3Uw+zway9pPyVFq5zgns1K
         1+devwCP9lniC7Fo9lu6zmM89XQhC73fH6CUVFuXa14xpITxYUlpZToNTt1b+lHZ9yb+
         8XvmOuQ2nK9peMFhZsNd8IVdZFgXjsb654qGhwr1dmii9Ulsw+y330Y2qZj9dyYQSlcz
         gvCORl9kSIUrjZ78T0tFDq/dTO1ZThZ4I6ShsmRmY7vL3iiArXi3wA8lA0NucmGw40lR
         3cx2G/jsOCfe6SPzYXb5cdAkjNYyb9K0J0q8tASStujMUv7A4Qb/fOXVrG9NS1x+eZZs
         s7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tuVn607FQC2Z7JxZDC4QieVMCILWTqSRSd3FAkHzFIQ=;
        b=AvqL5GF866CRmtWOjzr8yppBK++UTWQVaFUogg+ddjffNLUw9Dxh/StxRRXVbOZX6s
         J8eBC3x4xN4v+1wStSIxwwUWFCv7B+RCFh7m1W/KctLQUfAPrT4ykY9iDlUepUcRcoAv
         hAxOjNz1mgPDw+PLlBAxikQrhaGHDpIb0EVC14G/6M9RPz8cfolE5RQ1fxdvQl5TRQAK
         NhXLvvRDl6/HASeLenk4czRR/lPOWg8IxoLkN5K7GLngHkGLQ/m7WU83XAhjvQACX7Ht
         zDcciNxazMY/sRWAHFkhzg7P/Qmykf8HajKOR5JLw9nI+BgV9H3CxId25fovkt84V2Ig
         1C7w==
X-Gm-Message-State: AOAM531b+a9t7DBxV0aZtyYlwviNJ1yxuVMoCHsVKTWG/I4AjUv35H+i
        BMsNASr1RF0ZDHElUkfe6qK7jFR41oiVFzAS6hk=
X-Google-Smtp-Source: ABdhPJy+nSPA4QrRfuiDoKnn370u7t6o+6JuJA8WPbvYPIe4ynkvZ7hKyEIDnTu9F5iV2/iycqmZgA==
X-Received: by 2002:a17:90b:3647:: with SMTP id nh7mr3750158pjb.114.1606035126999;
        Sun, 22 Nov 2020 00:52:06 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id a3sm8728821pfd.58.2020.11.22.00.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 00:52:03 -0800 (PST)
Date:   Sun, 22 Nov 2020 19:52:00 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 01/32] sched: Wrap rq::lock access
Message-ID: <20201122085200.GA110669@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-2-joel@joelfernandes.org>
 <1489211d-594c-d244-0111-8bd8a27fb945@gmail.com>
 <20201120165522.GA1021337@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120165522.GA1021337@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 11:55:22AM -0500, Joel Fernandes wrote:
> On Fri, Nov 20, 2020 at 10:31:39AM +1100, Singh, Balbir wrote:
> > On 18/11/20 10:19 am, Joel Fernandes (Google) wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > 
> > > In preparation of playing games with rq->lock, abstract the thing
> > > using an accessor.
> > > 
> > 
> > Could you clarify games? I presume the intention is to redefine the scope
> > of the lock based on whether core sched is enabled or not? I presume patch
> > 4/32 has the details.
> 
> Your line wrapping broke, I fixed it.
>

Sorry, I've been using thunderbird from time to time and even though
I set the options specified in the Documentation (email-clients), it's
not working as expected.

> That is in fact the game. By wrapping it, the nature of the locking is
> dynamic based on whether core sched is enabled or not (both statically and
> dynamically).
>

My point was that the word game does not do justice to the change, some
details around how this abstractions helps based on the (re)definition of rq
with coresched might help.

Balbir Singh.
