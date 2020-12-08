Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916CA2D3105
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbgLHR2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbgLHR2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:28:02 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDD4C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 09:27:22 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CA932300;
        Tue,  8 Dec 2020 17:27:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CA932300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1607448442; bh=UoY//GkK/Dx8qCEM/QmcaS7DrGe59TUEybC2Gy2pTz0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jcQ8tW+ytHfKxMCkLP7vCQGppqyUNRrnvbfZQVnav7C0qI3Ywgw9Fc5mSe0JMV5br
         ZtrrqdDVvdTRMGwsJJqz+zkrzDc3C8M7algriRa79pIwe6moitIVzZ0aYMjBMIaHrr
         AjI6GlNyt2aaEUDpSySEWbspZ+I1CmUIU6h2l253gedaM6fKX4s89ecy/I9jSbpHoX
         rjWtwhnp4JdVkdMIeuanJz4ZiWI9RIOdIlIYNIAlH6uiaH/vsV9U0zu0b+o0AHRA4N
         9NRlLQj+mmbnzo5+x42UzCi1z99NG7DYpsNn2+Chi49SiKVfRMBN+eysqWOznL5AOg
         rXopXYYlea+2g==
Date:   Tue, 8 Dec 2020 10:27:20 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andrew Klychkov <andrew.a.klychkov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] (fixed after review) Documentation: fix typos found in
 admin-guide subdirectory
Message-ID: <20201208102720.1c235d0a@lwn.net>
In-Reply-To: <20201204070235.GA48631@spblnx124.lan>
References: <20201204070235.GA48631@spblnx124.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 10:02:35 +0300
Andrew Klychkov <andrew.a.klychkov@gmail.com> wrote:

> Fixed twelve typos in cppc_sysfs.rst, binderfs.rst, paride.rst,
> zram.rst, bug-hunting.rst, introduction.rst, usage.rst, dm-crypt.rst
> 
> Reviewed-by: Jonathan Corbet <corbet@lwn.net>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Andrew Klychkov <andrew.a.klychkov@gmail.com>
> ---
>  Documentation/admin-guide/acpi/cppc_sysfs.rst        | 4 ++--
>  Documentation/admin-guide/binderfs.rst               | 2 +-
>  Documentation/admin-guide/blockdev/paride.rst        | 2 +-
>  Documentation/admin-guide/blockdev/zram.rst          | 2 +-
>  Documentation/admin-guide/bug-hunting.rst            | 2 +-
>  Documentation/admin-guide/cifs/introduction.rst      | 2 +-
>  Documentation/admin-guide/cifs/usage.rst             | 6 +++---
>  Documentation/admin-guide/device-mapper/dm-crypt.rst | 4 ++--
>  8 files changed, 12 insertions(+), 12 deletions(-)

Applied, thanks.

jon
