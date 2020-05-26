Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4901D7A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgERNrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 09:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbgERNrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:47:47 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4249220657;
        Mon, 18 May 2020 13:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589809667;
        bh=OWTjpnAZkv7sUXgqDZ9dbdDlTjjTUSLdc+5YI8H9+UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sf1QAiTFSvJXJkMn5jRwradWooQaW1xX69MhjeMoAyGi/OaRVGC511vMbFHgmeTuw
         F1bu8RCpTz/H2b+ugOc/MlFVZ8XJ/Tubkt3ccgsnPoG1bUU2Qa5aJQDrGzn4dj4Oh6
         qQYG9kbTE01nA0am8NMbYygdIry9SQzDoXJqfYbo=
Date:   Mon, 18 May 2020 14:47:43 +0100
From:   Will Deacon <will@kernel.org>
To:     =?utf-8?B?546L56iL5Yia?= <wangchenggang@vivo.com>
Cc:     'Catalin Marinas' <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH] arch/arm64: Enlarge arm64 command line length to 4096
 bytes
Message-ID: <20200518134742.GH32394@willie-the-truck>
References: <00fc01d62d1a$35445a80$9fcd0f80$@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00fc01d62d1a$35445a80$9fcd0f80$@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 09:42:43PM +0800, 王程刚 wrote:
> Now android use many long command line, and oem need append some command
> line to debug boot, so 2048 bytes cannot able to meet the requirement.
> Enlarge arm64's command line length to 4096 bytes.

I thought bootconfig was supposed to fix this sort of thing?

Will
