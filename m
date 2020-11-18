Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2402B7720
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 08:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgKRHpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 02:45:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgKRHpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:45:43 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B90C22228;
        Wed, 18 Nov 2020 07:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605685542;
        bh=4DRoI+BKr4trGGWDzPevG4znBeha6mCBpwDZ9mXobeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSacRJiH4OlryV5pW1J5Wjg85Bh6UpegiD6mlEOeLdW9HGMOjHaqQxoZip9ClAJZD
         WNbQiBzkTVHxM9XttcvIKKWxkyK0laIn2tXhClhdMYimehcvqeDqjVPER66ufTx7LB
         UcHalGSyGwUNQfwlqwkdhzNOGItc0JEY193H48Z0=
Date:   Wed, 18 Nov 2020 08:46:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5b2t5rWp?= <penghao@uniontech.com>
Cc:     johan <johan@kernel.org>, jonathan <jonathan@jdcox.net>,
        tomasz <tomasz@meresinski.eu>, hdegoede <hdegoede@redhat.com>,
        dlaz <dlaz@chromium.org>,
        "kai.heng.feng " <kai.heng.feng@canonical.com>,
        "richard.o.dodd " <richard.o.dodd@gmail.com>,
        kerneldev <kerneldev@karsmulder.nl>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] Changes since v1  - Change subject form "ALSA" to
 "USB:"- Adjust to approoriate line
Message-ID: <X7TRVGHS9JMfoSx4@kroah.com>
References: <20201118065132.24772-1-penghao@uniontech.com>
 <X7TGU+JHUL4eTbG6@kroah.com>
 <97724690.63131.1605685268737.JavaMail.xmail@bj-wm-cp-6>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97724690.63131.1605685268737.JavaMail.xmail@bj-wm-cp-6>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 03:41:08PM +0800, 彭浩 wrote:
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

Message is now deleted.
