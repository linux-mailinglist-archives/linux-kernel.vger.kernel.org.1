Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A5D253E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 09:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgH0HBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 03:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgH0HBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:01:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8872DC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:01:21 -0700 (PDT)
Date:   Thu, 27 Aug 2020 09:01:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598511678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=itEhm3ICnTlf61Ty9BCh/7cEb9lcU3yOuFeK2GhTwb4=;
        b=G2uSblVikAoFcxDsI9Sm/BYHrpRdQ5YAGhD8SVJfhDxEFkdIG2+a6yy16t1gUsz4ZtG+zR
        o4kL5Tt9U5TSNVX24kqXLpi21nPQIYkF5+IK0wvWqD+ut9R8hRqfcCOXWizpWcTSqxBzjk
        6WhWWNOnnVeR0d4Nu1ywg38v/E27VDDDQm6pCjnmAbZtbYAZmOwAA5VeRplpXqZRsx2v96
        0pFnTja2EjQyeNhPh73EIFIgNNV0lJEEvawvQLgv9GAejJ8nFw2DT/KGw7KRI30Qa3eZan
        3E4egBGJD4gzL1p7Ls0quPWptINF6Sd9sG7wsHy8FPYJu4rncCmYFlq6d1kGcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598511678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=itEhm3ICnTlf61Ty9BCh/7cEb9lcU3yOuFeK2GhTwb4=;
        b=oZT0HngxFDUsOO9emAWLUc7TaJbw9jcadPk/yXL5zjhzfAassSApVT4p0v3Vy15S9Vhvv8
        KwpFcxlcM5bl4fCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] irqchip/eznps: Fix build error for !ARC700 builds
Message-ID: <20200827070117.fdmu4wxulop43mam@linutronix.de>
References: <20200825072152.725jmtlcqah5oos4@linutronix.de>
 <20200825180518.25300-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825180518.25300-1-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-25 11:05:18 [-0700], Vineet Gupta wrote:
> eznps driver is supposed to be platform independent however it ends up
> including stuff from inside arch/arc headers leading to rand config
> build errors.
> 
> Fix this specific reported error as quick hacks as the correct fixes are
> too much work:
>  - copy AUX_IENABLE from arch/arc header
>  - move CTOP_AUX_IACK from platform header
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://lkml.kernel.org/r/20200824095831.5lpkmkafelnvlpi2@linutronix.de
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

Thank you.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

in case it is not too late :)

Sebastian
