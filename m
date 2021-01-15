Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC452F8567
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387964AbhAOT23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:28:29 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58761 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbhAOT22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:28:28 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 69AB95C0140;
        Fri, 15 Jan 2021 14:27:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 15 Jan 2021 14:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmh.eng.br; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=h77nPCYht3txjg+nUmTjHkq/nfm
        P49yYK/WpXV7YqO8=; b=ipNtdEZJLlyTUIcPGINdeOubDZitwr/oEYae+hx8IyZ
        Vu5sy2yHBVUQ4bFJX8gjWsxGWPLpDWpaS3bWuYAp537z4aaaOIuf0A6gIcTJQJuS
        1nSLGETg04LufNmpw9BUwpZkC++v9HYNMvDFwAYFRNjnXFaTfhwLA+NjU/6tibRO
        4stfUk/K8TvDDepxYw9jGWdxFZYCQZTQSkUjkCbeFPS/O3v2Ia4xTE04VLG3oSp4
        JT52rOkXVyUH0jqcy5WgLFVAnm0N8vTMeCW7FGv1DQT1okLQ4GjSeH3dDZYHcWIW
        tznjBtX7e9TFbLYZrJFUzpzIUZBXyc5s4Dskpgn2+xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=h77nPC
        Yht3txjg+nUmTjHkq/nfmP49yYK/WpXV7YqO8=; b=elEiK2KcarRXZU5NvqbqaZ
        zzDo4odT8xcw4477cHOIdQJvaFO7yNVFVcvKP6KTOS1T6stWhgaboRb6l/+/UmXd
        9nm1ZFrQniCXZYW2+oZOkCYd5beuFYvVoDsrx7fk0HZAXWyO5flaHatzEFB0YJhw
        ezUVq62YXXsqYt1mD8fMqJKMW5IW9pz/JXcvIlsETr512yox3YXl0bJR5vJZoV2Z
        DiLNInfyBYOxtptnFrVoTDFS5ARzRCH70Ya4l6j3/2ztuVCLFPt+TDitOuykINxi
        Jg/eWVER27Qgot2FQNR4SxluWd+VOrt59Rn+MVYXIXm+ecmEh8B8qWqC7lV1aHvw
        ==
X-ME-Sender: <xms:mewBYGJ8y7Us_bMd2ObOf6EoiqVTxmd1g-HPIJqnynnZEF0Sq-1Tsg>
    <xme:mewBYOIdsicWpF0E8yuHlvdahcltBnulExjO2SiE9Ust9fLDDDetz5ZhCfQeNppVN
    WpQGmXyW6VjRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddvgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    dttddtredvnecuhfhrohhmpefjvghnrhhiqhhuvgcuuggvucfoohhrrggvshcujfholhhs
    tghhuhhhuceohhhmhheshhhmhhdrvghnghdrsghrqeenucggtffrrghtthgvrhhnpeevud
    etjeegiedufeeugfeiheeljeekfeduhfejfeegkeehkedvvdehheelgeevieenucfkphep
    udejjedrudelgedrjedrfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhephhhmhheshhhmhhdrvghnghdrsghr
X-ME-Proxy: <xmx:mewBYGsdaG3_XdRs3HlzBQfrwu8sZzQqdBQ7HXZIL_-WCcc55AG3pw>
    <xmx:mewBYLYUSk1K6XU7flDp2tTvcIXtRvI6kGdzpa67R6rsdw01rQBySw>
    <xmx:mewBYNYZMp8pqWXkzrJTMpjeo2V2-n11uwAnRaDQFq0YG5zvqTiw_w>
    <xmx:muwBYBHkM0HFzcxPMSg3ZeZMAIsu1N53dKtnlrBgQ5vvrY3snc2wpg>
Received: from khazad-dum.debian.net (unknown [177.194.7.32])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7DE8D1080057;
        Fri, 15 Jan 2021 14:27:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by localhost.khazad-dum.debian.net (Postfix) with ESMTP id 8E30F3403215;
        Fri, 15 Jan 2021 16:27:19 -0300 (-03)
X-Virus-Scanned: Debian amavisd-new at khazad-dum.debian.net
Received: from khazad-dum.debian.net ([127.0.0.1])
        by localhost (khazad-dum2.khazad-dum.debian.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 5Dz2lDureRDU; Fri, 15 Jan 2021 16:27:19 -0300 (-03)
Received: by khazad-dum.debian.net (Postfix, from userid 1000)
        id 0E0113403214; Fri, 15 Jan 2021 16:27:18 -0300 (-03)
Date:   Fri, 15 Jan 2021 16:27:18 -0300
From:   Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To:     Joe Perches <joe@perches.com>
Cc:     YANG LI <abaci-bugfix@linux.alibaba.com>, hdegoede@redhat.com,
        mgross@linux.intel.com, ibm-acpi@hmh.eng.br,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thinkpad_acpi: fix: use scnprintf instead of snprintf.
Message-ID: <20210115192718.GB10895@khazad-dum.debian.net>
References: <1609914976-28113-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <2d5f6ffcf47ec4675cde21ff52fc70a9dd13b023.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d5f6ffcf47ec4675cde21ff52fc70a9dd13b023.camel@perches.com>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jan 2021, Joe Perches wrote:
> On Wed, 2021-01-06 at 14:36 +0800, YANG LI wrote:
> > The snprintf() function returns the number of characters which would
> > have been printed if there were enough space, but the scnprintf()
> > returns the number of characters which were actually printed. If the
> > buffer is not large enough, then using snprintf() would result in a
> > read overflow and an information leak. This error was found with the
> > help of coccicheck.
> 
> In all cases, the buffer _is_ large enough.

Thank you for double-checking!

> _show function lengths are OK for all the uses with PAGE_SIZE.
> And it's probably better to use sysfs_emit for all the _show functions

Indeed.

-- 
  Henrique Holschuh
