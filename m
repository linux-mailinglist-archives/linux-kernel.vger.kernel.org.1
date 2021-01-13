Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0082F4642
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbhAMIPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:15:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbhAMIPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:15:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 420F423120;
        Wed, 13 Jan 2021 08:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610525703;
        bh=J7LmJ2YKIiDkUpN9L7+IuoA+asGOwpoV2qWgModPZ/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ha62Mq0P85qidYAyuhnV+2+BbpKxRHWXZAKcVkx054+SZnLBkp6L+ehMhun2tMjlc
         NuwIzsRCOOVgq61AlXNAkxxwfSiPUIEVN9RCBF9J5njadZtDSkkN8JTU/+VCpxJWTt
         XvXjhD4vX+E7PH/Wy0ZhajigTLDrRgHXtqp9HXc0=
Date:   Wed, 13 Jan 2021 09:14:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jin Chen Xin <cx.jin@cn.digi-group.com>
Cc:     Johan Hovold <johan@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Recall: [PATCH] drivers: add new VID/PID for supporting Teraoka
 AD2000
Message-ID: <X/6sArzgNWsb0nnd@kroah.com>
References: <HK0PR06MB3825AE0A0AB2B4A300BA566A9FA90@HK0PR06MB3825.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK0PR06MB3825AE0A0AB2B4A300BA566A9FA90@HK0PR06MB3825.apcprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 08:09:29AM +0000, Jin Chen Xin wrote:
> Jin Chen Xin would like to recall the message, "[PATCH] drivers: add new VID/PID for supporting Teraoka AD2000".

Mailing lists do not work that way, sorry :(

> * The information contained in this message is intended for the use of the individuals to whom it is addressed and may contain information that is privileged and confidential. If you have received this email by mistake, please discard this email immediately. Do not disclose, forward or copy.
> * 信息安全声明：本邮件(包括其任何附件）的信息，仅用于邮件列出的接收者使用，并且可能包含有特许和机密的信息。如果您误收到这封电子邮件，请通知发件人，并立即删除它，请勿透露、转发或复制。

This footer does not work for Linux kernel submissions, please remove
when sending patches.

thanks,

greg k-h
