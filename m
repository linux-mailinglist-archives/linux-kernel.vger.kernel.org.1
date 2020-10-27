Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD1229A45E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 06:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506133AbgJ0F5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 01:57:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39615 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506125AbgJ0F5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 01:57:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id e15so274769pfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 22:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rIXtE9eIBmSyzn31Z/uNryvkGlvAm0abAkkcpmLsqn4=;
        b=g2S0ntsbQMHpVAY/Dd+vwwj3+nP28HvyhlGCloCdgsNqqRxIycwurJzR6kq6VtWiLF
         KyZ3UzxbrhHQTD0gemaac9e5KZOak5gfTu1jDhHa5xsBxLyOxqzEq0Wt9wg3yGVb+CZf
         kaQztHUMQChKp3pHOs+nW9JmHMK/DaJa+aYYpHeE5KDOKchpWkl686UImNJLAtjiyu8j
         PBmVR6zTQnyZDC8El+2qiq1sk+DKrMbGOjofdw5FXXQECJ+xrfKsMVzk2M2Us5zF7cVZ
         DRliVN+7zy6pKh9B/T6h8A3JaAuakggHaCaj1kQi8ZVwyHaLfvhwsX2C1iUsgbwGQUuR
         8LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rIXtE9eIBmSyzn31Z/uNryvkGlvAm0abAkkcpmLsqn4=;
        b=aCP2x373W1HMwmAe43dv5Sa/LM+d/Zf//WUk9fxZxESQR0DIASyPJWJ5/2jZvwBkTd
         N4pet/8dymlu7Xmqxnh+YSfXBwWHCjsggXByMm0nEGPyoOgqHtmXZdMXenF4S860wU9u
         YGguAShj797YG/AX34fl5TXiXkvSudgPK5Lp0Js9CASSYQmd1qJIdQNkrR1mmuahkkGI
         oiPTDihB/LnYtwEAxZ9YW1kzEODcTzsySizLhrBZgR98LLhX3kJCHkK97dRAkynD3vKH
         J8+umLMG9wI5U7mkndOfnespkFR5/dkiWLMuAt2eQC42bwTPfrKyqllCl8gfib3ztVwn
         GBaA==
X-Gm-Message-State: AOAM532JZWWHos7k7qCFh8wzuWwnD3JoO8M+DjoUGvxMrKYb/vnoslyB
        OZLYW+lCtzQDoK37rj//jaI=
X-Google-Smtp-Source: ABdhPJzZbJGL2KSlrxcOtDwOtQ0uEdJZMAj+2EzYPYb/yGgxZEvDHVK8IsfbtJCubhMMIC+g9XSRcQ==
X-Received: by 2002:a63:c56:: with SMTP id 22mr534162pgm.194.1603778222272;
        Mon, 26 Oct 2020 22:57:02 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id n26sm551637pge.21.2020.10.26.22.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 22:57:01 -0700 (PDT)
Date:   Tue, 27 Oct 2020 14:56:58 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv4] perf kvm: add kvm-stat for arm64
Message-ID: <20201027055658.GA10292@jagdpanzerIV.localdomain>
References: <20200917100225.208794-1-sergey.senozhatsky@gmail.com>
 <20200929033450.GB529@jagdpanzerIV.localdomain>
 <20201013143709.GD1063281@kernel.org>
 <20201013152934.GC24974@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013152934.GC24974@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/13 23:29), Leo Yan wrote:
> On Tue, Oct 13, 2020 at 11:37:09AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Sep 29, 2020 at 12:34:50PM +0900, Sergey Senozhatsky escreveu:
> > > On (20/09/17 19:02), Sergey Senozhatsky wrote:
> > > > Add support for perf kvm stat on arm64 platform.
[..]
> > > Arnaldo, any opinion on this?
> > 
> > I'm not finding the actual patch, just this reply from you, lets try
> > with b4 using this message Message-Id... Magic! But it isn't applying,
> > can you please refresh the patch to what is in my perf/core branch?
> 
> I did a quick trying, the merge confliction is caused by the file
> tools/perf/arch/arm64/util/Build (for the new added tsc.c).
> 
> @Sergey, please help to rebase on the latest perf/core branch [1].

Will do by the end of today! Sorry for the delay, somehow this whole
followup conversation missed my inbox.

	-ss
