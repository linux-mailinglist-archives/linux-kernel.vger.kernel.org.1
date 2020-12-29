Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEDC2E6F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 11:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgL2KR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 05:17:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgL2KR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 05:17:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98912207BC;
        Tue, 29 Dec 2020 10:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609237036;
        bh=Pk6mNTq1P6Bdr8N/J1sp7GsdWv7O3sQjvXPIhAPxkn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWmEDq+X2EzACzFWWkq6SYXOiWa6J8qGj6FqsUG7boPM9M+SfsyCpntPaQ7Bysxn1
         CgB+u1gU8Zy/gB56taiXtmOqmMfCp9BBB/HkEJXnYTE2off9GwsQrO/IcwFz4IAFmT
         ZPGGc0eoPnEPTfhXFC52GycnqlWsA0AcJXaPhv/c=
Date:   Tue, 29 Dec 2020 11:18:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     broonie@kernel.org, rafael@kernel.org, david@lechnology.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap: debugfs: Fix a memory leak when calling
 regmap_attach_dev
Message-ID: <X+sCfIpEWJdxRhvj@kroah.com>
References: <20201229011617.3795455-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229011617.3795455-1-xiaolei.wang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 09:16:17AM +0800, Xiaolei Wang wrote:
> Fixes: 9b947a13e7f6 ("regmap: use debugfs even when no device")

This line goes down next to your signed-off-by line in the changelog
please.

thanks,

greg k-h
