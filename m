Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810F71B2128
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgDUIMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 04:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgDUIMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:12:45 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8F922072D;
        Tue, 21 Apr 2020 08:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587456764;
        bh=1H9QwtfRzvccm/6UIO24x9MzqKXa4D8yTbOu4Dq5x/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQQ23Uz8YyC72uR7qvCyCB7ongHObzSpaBlt47N0bJsb0h43EUlehbbNsrGKcbkwo
         S4GkkiCVW3f4FEndZ7S2S7FFCj3DxCOrcFEXB4YFOOiUDPtcX+P+IDbA5UIouZRFqe
         EH3cK58csffPTZbDqsgZdaSB2JFDVACIjwNKMkcA=
Date:   Tue, 21 Apr 2020 09:12:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        info@metux.net, allison@lohutok.net, james.morse@arm.com,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH] arm32: fix flushcache syscall with device address
Message-ID: <20200421081239.GA15439@willie-the-truck>
References: <1587456514-61156-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587456514-61156-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 04:08:34PM +0800, Tian Tao wrote:
> An issue has been observed on our Kungpeng916 systems when using a PCI
> express GPU. This occurs when a 32 bit application running on a 64 bit
> kernel issues a cache flush operation to a memory address that is in
> a PCI BAR of the GPU.The results in an illegal operation and
> subsequent crash.

A kernel crash? If so, please can you include the log here?

Will
