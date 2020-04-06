Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BF719F71F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 15:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgDFNjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 09:39:35 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40515 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgDFNjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:39:35 -0400
Received: by mail-qk1-f194.google.com with SMTP id z15so9922604qki.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 06:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5SNwj/cJOVMAuZhQjDO/H0JEQGzFg1APijFPsFLvQX4=;
        b=OChMS5kWnMrjvIoC73ACC1Gb1mPAnQkyVUTcGEmYhVhnq0jWiBPYxNXHEfg6j3Z7o8
         LpGqMuMkmNnnhSxswBQI3RS7reOyMTlFsxK5CO4hgSJndtprbKmXMRHkqK5fvvy+aeoM
         dPJKtRNGR5JCP+CpqK+tz81yCkq51Pi9Rr2dmMbQWEBtLtFRCz9f18iliL1bjsHECndG
         pwfqec1IOW44UOKGnPfc74qvs/d9Fx28Zs3kB874nWA4Z/aWn6XJBHonvNG5X94rYcS2
         7DlagueSpc0/T19Q7fnUeNhd3jjfSwMkTlYwGEZgqb5gFvuowTrgZYBTC5UB6xSKWS+D
         RJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5SNwj/cJOVMAuZhQjDO/H0JEQGzFg1APijFPsFLvQX4=;
        b=hik7WolKhX61VpD7lCLTVUuAFqaGgC/0yMC6U0h2mwUSgNN5kONryvLMg73mHWUssn
         eWGO/mqzfqvIsnszRxRkwN9KydluX8SNJy0JNpP0vF2gN8RqeXTUrRDTATplGABinM3J
         3Sz3C9/H7AA2zm3lNJO+36MZAb43kDVAApcuPPJDtQwVUi/XelI3kyJeF4t/sI+rAYaM
         U5A6rkhFzikX6CtXLgEcRW5fb/PW5iKp4Gnfn1pdCl5Hzf88d46tiCdoQABS3JP/FRnU
         gpC2qECinbUf9gR4nRaqQ0fqmGeVSaQXhn4Lg0HrzJV+ycUKV+Xw8cMtJ4W58RUYGhaC
         whYg==
X-Gm-Message-State: AGi0PuacedqDwoOapdKnpcjfq0LD1hOUtimz+ED7UrEehujkWs/MariC
        hjw4zF9A9CR90bnY+A3HK50=
X-Google-Smtp-Source: APiQypIcQ4R0xMPdEYxkxLKD7uz7HWuRCPjWhyDzvrJOgFnJcvVxucm3/3GavMyDhPtVqb5YRf72qg==
X-Received: by 2002:a37:7fc3:: with SMTP id a186mr21404413qkd.251.1586180374442;
        Mon, 06 Apr 2020 06:39:34 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id c17sm7373415qke.44.2020.04.06.06.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 06:39:33 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 16707409A3; Mon,  6 Apr 2020 10:39:31 -0300 (-03)
Date:   Mon, 6 Apr 2020 10:39:31 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Simplify auxiliary event printing functions
Message-ID: <20200406133931.GB29826@kernel.org>
References: <20200402141548.21283-1-adrian.hunter@intel.com>
 <20200403104802.GJ2784502@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403104802.GJ2784502@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 03, 2020 at 12:48:02PM +0200, Jiri Olsa escreveu:
> On Thu, Apr 02, 2020 at 05:15:48PM +0300, Adrian Hunter wrote:
> > This simplifies the print functions for the following perf script
> > options:
> > 
> > 	--show-task-events
> > 	--show-namespace-events
> > 	--show-cgroup-events
> > 	--show-mmap-events
> > 	--show-switch-events
> > 	--show-lost-events
> > 	--show-bpf-events
> > 
> > Example:
> > 	# perf record --switch-events -a -e cycles -c 10000 sleep 1
> >  Before:
> > 	# perf script --show-task-events --show-namespace-events --show-cgroup-events --show-mmap-events --show-switch-events --show-lost-events --show-bpf-events >out-before.txt
> >  After:
> > 	# perf script --show-task-events --show-namespace-events --show-cgroup-events --show-mmap-events --show-switch-events --show-lost-events --show-bpf-events >out-after.txt
> > 	# diff -s out-before.txt out-after.txt
> > 	Files out-before.txt and out-after.tx are identical
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
