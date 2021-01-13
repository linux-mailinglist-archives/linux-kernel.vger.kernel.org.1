Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B9E2F5781
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbhANCBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbhAMXhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:37:51 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332C8C0617A2;
        Wed, 13 Jan 2021 15:24:25 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9A8646132;
        Wed, 13 Jan 2021 23:24:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9A8646132
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610580265; bh=Q7+Y7LKXkVAGeN134Mxv0g5tuHJqDerkJg9QZMMJMlg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EAOrejo3tVWr3rPpO8hgQAeLiN8gOTu02A2DHlM1DsBhay2XXvj1CD7O9m7a3oWS8
         9bgiywwl82dzrrcpcjkKLZnVas/Q3pKM98tsanVzYF0TpxZg+SZH80hsvSvdtOKdNA
         ECfJWYVzLgzm2VDtH7shgckzztimqDnnj9c6jTW5iDeRYIePV4f/2rBfl8BVwqXS4e
         F9J9eqOmw4C+1kf0K7T+zulEUQNaGBEg+bysOh9fqu1C3w/JVXEpPlFQPS7Ceu9LG4
         vUW3/0FBfK5f4JS4u0oei7OmbHaCL6qSuQy2ig+Q03HcPyVgYQ96/qo9Q8O8I3Igxg
         P3X0Od1Mt0Izg==
Date:   Wed, 13 Jan 2021 16:24:23 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Yanteng Si <siyanteng@loongson.cn>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for doc-next] doc/zh_CN: mips: use doc references
 instead
Message-ID: <20210113162423.5255f7b8@lwn.net>
In-Reply-To: <20210113070557.28792-1-lukas.bulwahn@gmail.com>
References: <20210113070557.28792-1-lukas.bulwahn@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 08:05:57 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> The Chinese mips translations refer to non-existing labels in the original
> documentation. Hence, make htmldocs warns about those undefined labels on
> all files in ./Documentation/translations/zh_CN/mips/.
> 
> Replace the references to non-existing labels with suitable doc references.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied, thanks.

jon
