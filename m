Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1512FE4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbhAUIIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:08:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727155AbhAUIID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:08:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75AE72395B;
        Thu, 21 Jan 2021 08:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611216442;
        bh=ULOF0RKpCQatdeS4/BZIJEM+KsLsQ9flYSbVoOHE030=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=edtl+9LeUOrxuI6IxKBlHvEcA5oFoR0TXDfMcs1KmP8wlGMVswJq3Xgw9cHPd7GZE
         vAKyPWQOqDGWY/5hgmPJ06JEypN81l62l2nL+1e54HCMxY9wpgH4BH9tGOFmte6hce
         Tt0DiHlDfHKTgwwoxNihVbQhSy0ugHQ7+8ug+A9Q=
Date:   Thu, 21 Jan 2021 09:07:18 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "ricky_wu@realtek.corp-partner.google.com" 
        <ricky_wu@realtek.corp-partner.google.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "levinale@google.com" <levinale@google.com>,
        "keitasuzuki.park@sslab.ics.keio.ac.jp" 
        <keitasuzuki.park@sslab.ics.keio.ac.jp>,
        "kdlnx@doth.eu" <kdlnx@doth.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtsx: pci: fix device aspm state bug
Message-ID: <YAk2NtOqIohpBJIt@kroah.com>
References: <20210121072858.32028-1-ricky_wu@realtek.com>
 <8563fc3264ad4f46bfa05a3cbdb7d644@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8563fc3264ad4f46bfa05a3cbdb7d644@realtek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 07:33:03AM +0000, 吳昊澄 Ricky wrote:
> Hi Greg kh,
> 
> This patch to fix misc: rtsx bug for kernel 5.4

I do not understand what this means, sorry.  Can you please explain it?

greg k-h
