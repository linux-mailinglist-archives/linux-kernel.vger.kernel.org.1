Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E82226FE70
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgIRN1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgIRN1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:27:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E11D235F9;
        Fri, 18 Sep 2020 13:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600435624;
        bh=hdwnMPLpGkF7fT8HWagP8iLQc7ygLaH1adjoC0v3BbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WcGBfKNOHsfTpxZ4LybE/LCjDG/vBCxvAPCaNa83KdcnvimqEK/JvVX3wmFOCXneL
         PZP06JuXc+jw7A0ghwZ22iELAZ4x7UNSwCjf+QpQUTXfkrlIYWPstf7umxLQPnFYoK
         4hkgJiSNsFwte3sOjvmjc2RpWLlVgULcGV6VAnYA=
Date:   Fri, 18 Sep 2020 14:27:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Bailu Lin <bailu.lin@vivo.com>
Cc:     catalin.marinas@arm.com, corbet@lwn.net, harryxiyou@gmail.com,
        alex.shi@linux.alibaba.com, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH v2] Documentation: Chinese translation of
 Documentation/arm64/amu.rst
Message-ID: <20200918132659.GB31232@willie-the-truck>
References: <20200915025822.29885-1-bailu.lin@vivo.com>
 <20200918092136.23190-1-bailu.lin@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918092136.23190-1-bailu.lin@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 02:21:36AM -0700, Bailu Lin wrote:
> This is a Chinese translated version of Documentation/arm64/amu.rst
> 
> Signed-off-by: Bailu Lin <bailu.lin@vivo.com>
> ---
> Changes in v2:
>  - Add index to arm64 directoy.
>  - Fix a document format error.
>  - Correct email encoding format.
> ---
>  Documentation/arm64/amu.rst                   |   4 +
>  .../translations/zh_CN/arm64/amu.rst          | 102 ++++++++++++++++++
>  .../translations/zh_CN/arm64/index.rst        |   2 +
>  3 files changed, 108 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/arm64/amu.rst

I'm supportive of translations for our documentation, but I can't really
review this! Assuming it doesn't say anything rude, then I'll leave it
for Jon to pick up.

Will
