Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC64D296176
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901162AbgJVPJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508401AbgJVPJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:09:21 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A2902463B;
        Thu, 22 Oct 2020 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603379361;
        bh=Y0d31MCd7iF1n8mpTmmY56veXW/p9uyGuBb+wm9qfwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=03Vg39bqQt7MJHrm74xDQwBBczyOiwgWBu3F1mKdh2H6WFxAgUv2atsgDP3laVAKA
         ltTEV4JWRHN9MD3eptzWn6DDgF23sFVqFnoAZ7bnZAz/+sKc/ejT4ZryVLmpR2e4zK
         NS9KG0Ybg99kW3T99h24zH336hbpKhIQqBuY2NPw=
Date:   Thu, 22 Oct 2020 17:09:17 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] module: some refactoring in module_sig_check()
Message-ID: <20201022150916.GB8608@linux-8ccs>
References: <789a4e5c-8efd-bb1c-86e2-eed8b2b7b0af@omprussia.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <789a4e5c-8efd-bb1c-86e2-eed8b2b7b0af@omprussia.ru>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Sergey Shtylyov [13/10/20 23:32 +0300]:
>Here are 2 patches against the 'modules-next' branch of Jessica Yu's 'linux.git' repo.
>I'm doing some little refactoring in module_sig_check()...
>
>[1/2] module: merge repetitive strings in module_sig_check()
>[2/2] module: unindent comments in module_sig_check()

Hi Sergey,

I'm fine with these patches, but are you still planning on sending a
v2 based on Joe Perches' suggestions?

Thanks!

Jessica
