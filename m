Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503D41B595C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 12:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgDWKiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 06:38:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:32960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgDWKiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:38:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CCE02076C;
        Thu, 23 Apr 2020 10:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587638283;
        bh=KyomFxagEayr+VB2nK8DKmpz/6y+yyaLMLKe53am9tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQjuvyY3RRm0GRhu0VrpkHciZ6EuPO2kL22t+xPgp+a7ZY+LfZIAnvwafGm38zSZf
         3u+NotK1CA+tV8WB081VmRfXb1CsMK1nY7wtAURd0F/nj78P/EqqCZuyGmvsgHdxlv
         8t2mNWuRj9fJOoBk+5yHa+G1A/QQgqS3CARVGUC4=
Date:   Thu, 23 Apr 2020 12:38:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xujialu <xujialu@vimux.org>
Cc:     masahiroy@kernel.org, akpm@linux-foundation.org,
        mchehab+huawei@kernel.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: gtags_files_generator.sh
Message-ID: <20200423103801.GA3730892@kroah.com>
References: <20200423095331.8032-1-xujialu@vimux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423095331.8032-1-xujialu@vimux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 05:53:31PM +0800, xujialu wrote:
> Signed-off-by: xujialu <xujialu@vimux.org>
> ---
>  scripts/gtags_files_generator.sh | 34 ++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100755 scripts/gtags_files_generator.sh

I can't accept any patch without a changelog text.
