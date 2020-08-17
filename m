Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A27245A96
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 04:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgHQCEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 22:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgHQCEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 22:04:24 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E68C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 19:04:24 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id v1so5254644qvn.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 19:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CFiY3DY6cslHkwdpXio3r0ZgfBZWH6WZghS3DOzDvbs=;
        b=XzIc1LB7zNMRY97nQaQrYQmqd2+mTcoMCBdBAS9cZzqA6MaAd9TBiB4FlNJjl2t7fB
         RuaEw9YmY05DkEPNn2EAmDHbq23ocV7VyiURobDoXfSk7GTlTm+CKTpqJq1dytYjYMvW
         qcskH29ike473RlM73Lo8cUDWfVsbS/oqLXA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CFiY3DY6cslHkwdpXio3r0ZgfBZWH6WZghS3DOzDvbs=;
        b=Df9+tNWsCIAe9sdGpqfYFwAHmKNtXn2aLV6Ar2Bio69oI4UL0qiPVOqlbBFzvZGizW
         7xrK1XBMW0VT46nf+YlsXayxHkAEb+NiVDhbzt/Oy4D4TFk8EJ6BR5E2HLxIjxlg1ufF
         Rn59whs0Eq51rJzOl2W6C7nHVfiU2my4GVUHeUdtALGxdvlhxDNG5mT/jKJertXE9nU7
         gG6jgZy8humoUbAnwJ5SBDUpQ8qRdoXlZyTJ99h/pu6NspdK7zp8OPNxJXHh7FQ8vo/T
         Ci0p5dVB7X8QSu+qvlk4R13JliqTi8IdqgnWhmZ+oGxtDuMIyScTMdzm25pPGnNPZHDx
         P0xw==
X-Gm-Message-State: AOAM532LnqfyCdKNrTtpM9+KcxONvkkG/68taQcm4ePQtV8NgleWtnrW
        bjajwy1J+Cc/4rcxaB3Wz3NcsSuyZfDvnw==
X-Google-Smtp-Source: ABdhPJwDM5yAZ2IdsIUmrvyCc0Z+nvp3BQe97AfnOk4yWudxKvBTfVNSiqybv/kKEjgmXgTbkLo1pw==
X-Received: by 2002:a05:6214:1302:: with SMTP id a2mr12754248qvv.156.1597629862731;
        Sun, 16 Aug 2020 19:04:22 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x7sm15271273qkn.53.2020.08.16.19.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 19:04:22 -0700 (PDT)
Date:   Sun, 16 Aug 2020 22:04:21 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        fweisbec@gmail.com, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH RFC 01/12] irq_work: Add support to detect if work is
 pending
Message-ID: <20200817020421.GA1492280@google.com>
References: <20200815031908.1015049-1-joel@joelfernandes.org>
 <20200815031908.1015049-2-joel@joelfernandes.org>
 <20200815081330.GF2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815081330.GF2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 10:13:30AM +0200, peterz@infradead.org wrote:
> On Fri, Aug 14, 2020 at 11:18:57PM -0400, Joel Fernandes (Google) wrote:
> 
> https://lkml.kernel.org/r/20200722153017.024407984@infradead.org

Thank you, so that means I can drop this patch then.

 - Joel

