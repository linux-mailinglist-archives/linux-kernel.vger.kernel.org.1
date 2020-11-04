Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129F72A6692
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgKDOlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728522AbgKDOlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:41:36 -0500
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA8BD20739;
        Wed,  4 Nov 2020 14:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604500896;
        bh=iAoAP6oWMQNP6J7FU2Y8AJTsRi/1fWUHdR19uI71nwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VFVjJiZhNjYbxqCSbu+PlNgUvLScpWe7UMqVs1fvbXFddtWjlGb+5DQUC6F3n23Pm
         Bd5CbKAtpHYgKuFS2k543Ugu2SqiZrU/oA01+PC0pkSl2hqsw9kKdkZTgQDPdJcDFy
         rXv4AG2oCgfI6m9DQe8zqJUu1zI01yw8shlEjiOA=
Date:   Wed, 4 Nov 2020 15:41:31 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 0/3] module: refactor module_sig_check()
Message-ID: <20201104144130.GA14910@linux-8ccs>
References: <22e48a3d-06ee-5b8e-6e56-3694871a7c2f@omprussia.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <22e48a3d-06ee-5b8e-6e56-3694871a7c2f@omprussia.ru>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Sergey Shtylyov [31/10/20 23:05 +0300]:
>Here are 3 patches against the 'modules-next' branch of Jessica Yu's 'linux.git' repo.
>I'm doing some refactoring in module_sig_check()...
>
>[1/3] module: merge repetitive strings in module_sig_check()
>[2/3] module: avoid *goto*s in module_sig_check()
>[3/3] module: only handle errors with the *switch* statement in module_sig_check()

Applied to modules-next. Thanks Sergey for the cleanups!

Jessica
