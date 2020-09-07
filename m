Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86C825FE20
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 18:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgIGQIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 12:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730239AbgIGQF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:05:57 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E42802087D;
        Mon,  7 Sep 2020 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599494755;
        bh=QeHIkF/ix+36XFjoiPIijp204FQoC8LDlQRpbEiIysg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Socdqn0EXGvMtm8FRILCbjcfp7AsK5TCutrjKh1GILpklZ7512+lBf83RxCbPJ5vD
         K8gojHaAp54F2cRf2AYGcCnGy1PXXc36qTauT2r+yEPXfm/n2cvkwjmWDp4XBUvedq
         krEp9gJL+uWIzpUt6HDaFZg1vcbXeJOY4rMgHl4I=
From:   Will Deacon <will@kernel.org>
To:     maz@kernel.org, julien.thierry.kdev@gmail.com,
        linux-kernel@vger.kernel.org, Xiaoming Ni <nixiaoming@huawei.com>,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        wangle6@huawei.com
Subject: Re: [PATCH] arm64: fix some spelling mistakes in the comments by codespell
Date:   Mon,  7 Sep 2020 17:05:35 +0100
Message-Id: <159948473119.582952.94642666556393887.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828031822.35928-1-nixiaoming@huawei.com>
References: <20200828031822.35928-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 11:18:22 +0800, Xiaoming Ni wrote:
> 


Applied to arm64 (for-next/tpyos), thanks!

[1/1] arm64: fix some spelling mistakes in the comments by codespell
      https://git.kernel.org/arm64/c/ad14c19242b5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
