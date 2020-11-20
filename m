Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CAB2BB0FA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgKTQz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbgKTQz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:55:26 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754A4C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 08:55:26 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id f15so4064334qto.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 08:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fP9H0NfmnH39CvoMhVDgN4MIBYLW4dx4A1D7re6k5gk=;
        b=A7nnsNFzrs19WzwXPOcfgoQ5JHYBzmxO1EAo4F5bjJ8eWLbxaMFpV+Y6jHXGPB3hUW
         k9XxBfRkz+BbHIjQOg9kQ9ajar8VcjbCAeMjbth+mvLj3kZd2EXyfniXaV7BXdnOEJpW
         I2PlrcjSkpA/BJJ0h8FWQOwsGTauXI+Es3npw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fP9H0NfmnH39CvoMhVDgN4MIBYLW4dx4A1D7re6k5gk=;
        b=RPdw/Tda4b0XM/i6Yr80nCT+bdeeUnYsOT62wFEkYFtpdmPk/Jr8X9kaITn8vwEY2H
         oJVI9O60m0BfGVOu4GpbQ1QAZunWK06umdmoalLEoXpS6WgFd4irK8/FK2tA7QybGFSI
         DH/pnj3XXPckBeWzGv4/vA2hufWgFzIVV+O0CwjaI2TmLF8cgZeRp5QFCp7LiXobPMlm
         cklq/6nTVQwl+UQfZ9pBAYmUTHrnvJXJcwgZPdoUpc8jPvagagqwCTlYtgMuCpA1h+Nr
         dkb+k3q1Ic1SjwCvFV4blh/7Ce3EKI391/GbSGSd6s0n3eGs2YXMV5h1IlUTYMD2IeTR
         +3jQ==
X-Gm-Message-State: AOAM5329JCCJwCmqWTnRb+cvQYrOiWbI3MQHkF8BOWaSTVCaj1izqk19
        1606ESLMOdA6MaWswoHKgnyVMw==
X-Google-Smtp-Source: ABdhPJxmn6oVWR/xWqYDbDhHu1EsrrkLU1zUpnfYSEU62rOSprJ1z/s50Ysi8ADShK+pmdMBVlLR5g==
X-Received: by 2002:ac8:44cf:: with SMTP id b15mr16057309qto.325.1605891323285;
        Fri, 20 Nov 2020 08:55:23 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id v16sm2394875qka.72.2020.11.20.08.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 08:55:22 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:55:22 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Singh, Balbir" <bsingharora@gmail.com>
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
Message-ID: <20201120165522.GA1021337@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-2-joel@joelfernandes.org>
 <1489211d-594c-d244-0111-8bd8a27fb945@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489211d-594c-d244-0111-8bd8a27fb945@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 10:31:39AM +1100, Singh, Balbir wrote:
> On 18/11/20 10:19 am, Joel Fernandes (Google) wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > In preparation of playing games with rq->lock, abstract the thing
> > using an accessor.
> > 
> 
> Could you clarify games? I presume the intention is to redefine the scope
> of the lock based on whether core sched is enabled or not? I presume patch
> 4/32 has the details.

Your line wrapping broke, I fixed it.

That is in fact the game. By wrapping it, the nature of the locking is
dynamic based on whether core sched is enabled or not (both statically and
dynamically).

thanks,

 - Joel

 
> Balbir Singh
