Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5B61FEFC6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 12:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgFRKk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 06:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbgFRKk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:40:57 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD4FA2070A;
        Thu, 18 Jun 2020 10:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592476857;
        bh=7lAlMhCxQd0BiaTtbS/UPLzWqxDbBJolmFufkjeg4hU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5y8IbPXVHOdmvq3Zm92nObVYL/7sAVAuT4tjHp4gu6FZWPa/iX0IV2ohPig78mI/
         Yn6MLxGXZHq0djRK8ce4w9lUXPG3gs7W88JsIQZIiCyMK85WcBcpR63fsnzKAKMOvM
         jIakxRpNLgnpmMZl/yRWAfWz8wERVwJz818lGvtA=
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] arm64: kexec_file: Use struct_size() in kmalloc()
Date:   Thu, 18 Jun 2020 11:40:47 +0100
Message-Id: <159247357675.11586.8446389951509984593.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200617213407.GA1385@embeddedor>
References: <20200617213407.GA1385@embeddedor>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 16:34:07 -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: kexec_file: Use struct_size() in kmalloc()
      https://git.kernel.org/arm64/c/bf508ec95ca3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
