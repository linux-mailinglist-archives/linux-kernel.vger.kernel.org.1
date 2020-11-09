Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AE52ABD18
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgKINm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:42:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730509AbgKINAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:00:32 -0500
Received: from linux-8ccs.fritz.box (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C2B21D40;
        Mon,  9 Nov 2020 13:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604926832;
        bh=fORNRQqrMM/5fXUpz2ydYPm4DogCUWX0CXOLlA1kvJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Zqno9Q19xYyvu3YogpQnZo0JshITpJlx5OmkHfRzH/zFQeSrQBmJIDmIzeEOzUrE
         fzF6BnrKh03OFkjFERzgIY6BLMvW5Am0UqRQZT8ARSkqaT1tCAwggutT2Tx7OEK11R
         80zTPipo9rt8mQC5nJ/yloaSQrHuzU944+InxlzQ=
Date:   Mon, 9 Nov 2020 14:00:28 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] module: add/fix 'kernel-doc' comments
Message-ID: <20201109130028.GA24810@linux-8ccs.fritz.box>
References: <8fe9a7be-9f32-6724-a20f-9659b418f184@omprussia.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8fe9a7be-9f32-6724-a20f-9659b418f184@omprussia.ru>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Sergey Shtylyov [04/11/20 23:33 +0300]:
>Here are 2 patches against the 'modules-next' branch of Jessica Yu's 'linux.git' repo.
>I'm cleaning up the 'kernel-doc' function comments...
>
>[1/2] module: fix up 'kernel-doc' comments
>[2/2] module: add more 'kernel-doc' comments

Applied, thanks!

Jessica
