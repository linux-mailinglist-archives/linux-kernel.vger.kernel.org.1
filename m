Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6592EEC17
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 05:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbhAHECI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 23:02:08 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:44983 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbhAHECI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 23:02:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610078507; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=VucVYXBppIslG52iPfELeNHNg0r2vx8lWfv0KROfEoM=; b=p/vYnrBQbWlx+Uxiy7O8NbgY2mqNiN/9pObijAzoCdeLIWRfjuOVxo4D1X7cBgKlPiKUUBnG
 ygMWlxVlerNfIm6rh/Guf9hSLoft1wNVlwnczUGJf+BDChT0Ft6UuuWL/1aUCFCgXdZj4Fj/
 zk1zdi/yzsRajr6zIavRh4DlC/M=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5ff7d901b00f200123cf9f70 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 08 Jan 2021 04:01:05
 GMT
Sender: tingweiz=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F1D45C433CA; Fri,  8 Jan 2021 04:01:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1EA9C433CA;
        Fri,  8 Jan 2021 04:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1EA9C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingweiz@codeaurora.org
Date:   Fri, 8 Jan 2021 12:00:55 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     tingwei@codeaurora.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Set DBGCLAIM when self-host debug is enabled
Message-ID: <20210108040055.GA11529@codeaurora.org>
References: <512a30e6cc6877687c10c0f9ccc3c4c5@codeaurora.org>
 <20210106122356.GC26994@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106122356.GC26994@C02TD0UTHF1T.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 08:23:56PM +0800, Mark Rutland wrote:
> On Wed, Jan 06, 2021 at 06:29:53PM +0800, tingwei@codeaurora.org wrote:
> > Hi Will and Mark,
> 
> Hi Tingwei,
> 
> > In recent implementation of save/restore ARM debug registers in
> > EL2/EL3, we found it's necessary to know whether self-host debug is
> > enabled so EL2/EL3 can avoid saving/restoring debug registers but no
> > one is using debug.
> 
> In what situation are you considering? I assume you mean idle sequences
> using CPU_SUSPEND?
> 
> Generally our expectation for CPU_SUSPEND is:
> 
> * Where StateType==0, the debug state is preserved with all other
>   PE state.
> 
> * Where StateType==1 and the PE returns "warm" without having entered a
>   powerdown state, the debug state is preserved along with all other PE
>   state.
> 
> * Where StateType==1, and the PE returns "cold" after having entered a
>   powerdown state (i.e. we return via the entry point address), the
>   debug state is not preserved.
> 
> ... and I'm missing where you could avoid saving the state. What
> situation(s) did you have in mind?
> 
In StateType==1 case, EL2/EL3 can save debug registers before PE suspend
and restore them after PE resume. If EL2/EL3 doesn't know whether external
debugger or self-host debugger is using debug registers, it can save and
restore bindly everytime. However, if EL2/EL3 can get the information from
DBGCLAIM, it can only save/restore debug registers when debug is ongoing
which means DGBCLAIM[0] is set by external debugger or DGBCLAIM[1] is set
by self-host debugger.

> > In ARM PSCI, it has one option to set DBGCLAIM[1] to 1 to indicate
> > that debug is in use by a self-host debugger. Do you think it's
> > resonable to add this to Kernel?
> > 
> > For example, can we set DBGCLAIM[1] to 1 in enable_debug_monitors()
> > and clear it in disable_debug_monitors().
> 
> I was under the impression that this was solely for the benefit of an
> external debugger, and should have no functional impact on the PSCI
> implementation from the kernel's PoV, so as above I think we need a
> better description of the case you're trying to address.

If self-host debugger like gdb/kgdb is used for debug, Kernel can set
DBGCLAIM[1] to inform EL2/EL3.

Thanks,
Tingwei
> 
> Thanks,
> Mark.
