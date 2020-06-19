Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BB4201B85
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 21:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390051AbgFSTmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 15:42:42 -0400
Received: from ms.lwn.net ([45.79.88.28]:55412 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389884AbgFSTmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:42:42 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8289723B;
        Fri, 19 Jun 2020 19:42:41 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:42:40 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jens.wiklander@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, tee-dev@lists.linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] Documentation: tee: Document TEE kernel interface
Message-ID: <20200619134240.6c5b93d4@lwn.net>
In-Reply-To: <1591253979-29067-1-git-send-email-sumit.garg@linaro.org>
References: <1591253979-29067-1-git-send-email-sumit.garg@linaro.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Jun 2020 12:29:39 +0530
Sumit Garg <sumit.garg@linaro.org> wrote:

> Update documentation with TEE bus infrastructure which provides an
> interface for kernel client drivers to communicate with corresponding
> Trusted Application.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
> 
> Changes in v2:
> - Add TEE client driver example snippet.
> 
>  Documentation/tee.txt | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)

Applied, thanks.

jon
