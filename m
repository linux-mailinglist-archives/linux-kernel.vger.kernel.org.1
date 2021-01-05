Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E683F2EA520
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 07:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbhAEGBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 01:01:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbhAEGBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 01:01:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49F24229C4;
        Tue,  5 Jan 2021 06:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609826455;
        bh=YwjkAkfsuHFAswhz6QI+huh4A7nm2RaikGIE7W3aedc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWxdvD8o8JU41dWnPhwE0N8RFIsOzCtyJAFskM61GPwqbMN1/25brhZWGXYfpghXm
         6TfCo2wiR6FG1UmPL0iGQbmHPssyKueyCC5rHp8FerSqmwP/XxJwS7cp/p4MmbjhRL
         8jSR093tfMS8HikHKtcLb7/9/thrDJ0v6C/6+1P8=
Date:   Tue, 5 Jan 2021 07:00:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Meng.Li@windriver.com
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        james.quinlan@broadcom.com, Kexin.Hao@windriver.com
Subject: Re: [PATCH v2] drivers core: Free dma_range_map when driver probe
 failed
Message-ID: <X/QAk+bJoCc7lf05@kroah.com>
References: <20210105054148.13625-1-Meng.Li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105054148.13625-1-Meng.Li@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 01:41:48PM +0800, Meng.Li@windriver.com wrote:
> From: Limeng <Meng.Li@windriver.com>

This does not match your signed-off-by line :(

