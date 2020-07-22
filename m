Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B1C229584
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 11:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgGVJyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 05:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgGVJyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:54:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4C2920714;
        Wed, 22 Jul 2020 09:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595411689;
        bh=bts/svk+tjNZFRH+l8RAchMxCG2OEN5ZdKe6klQRvwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=km5/D4G2xonZmIK1g1Wjs9as4EEswLMvzsd8OAkHJgNcthwyhUmWEa90lOXVkNRWD
         1bvJ+pcEG/8+UF7U+wgSd26rNJlZcFs4aQiB5ktJujflu6EwL/TwUwf0IQnSWLMAgE
         paO9x1KHEzQlbDsMjHyeXLWtonHulI58mHNMFrao=
Date:   Wed, 22 Jul 2020 11:54:55 +0200
From:   gregkh <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5b2t5rWp?= <penghao@uniontech.com>
Cc:     perex <perex@perex.cz>, alsa-devel <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        tiwai <tiwai@suse.com>,
        =?utf-8?B?6JSh5YWG6bmP?= <caizhaopeng@uniontech.com>,
        =?utf-8?B?6YOR5YW05pe6?= <zhengxingwang@uniontech.com>,
        =?utf-8?B?6YKi5YGl?= <xingjian@uniontech.com>
Subject: Re: 14216-add-prevent-wakeup-from-s3-by-lenovo-Thinkcentre-TI
Message-ID: <20200722095455.GA2816990@kroah.com>
References: <1059302318.389895.1595410349231.JavaMail.xmail@bj-wm-cp-8>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1059302318.389895.1595410349231.JavaMail.xmail@bj-wm-cp-8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 此电子邮件消息仅供预期收件人使用，其中可能包含保密或特权使用信息。如果您不是预
> 期收件人，请勿使用、传播、分发或复制此电子邮件或信赖此邮件采取任何行动。如果您
> 误收了此邮件，请立即回复邮件通知统信软件技术有限公司发件人，并删除误收电子邮件
> 及其相关附件。感谢配合！
> 
> This email message is intended only for the use of the individual or entity who
> /which is the intended recipient and may contain information that is privileged
> or confidential. If you are not the intended recipient, you are hereby notified
> that any use, dissemination, distribution or copying of, or taking any action
> in reliance on, this e-mail is strictly prohibited. If you have received this
> email in error, please notify UnionTech Software Technology  immediately by
> replying to this e-mail and immediately delete and discard all copies of the
> e-mail and the attachment thereto (if any). Thank you.

This is not compatible with kernel development, sorry, now deleted.

greg k-h
