Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B7B2EFB9F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 00:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAHXRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 18:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAHXRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 18:17:30 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714A1C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 15:16:50 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 43F73C01E; Sat,  9 Jan 2021 00:16:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1610147764; bh=EIJ3VFsukrboXt6dlSV6x9vCPLwaTFNwnBDwe0e29MA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljRVZFYdlSHVLjOlc7/r5zZfWa2AoPX5DSdsq4hSzf+OVrSVOLqGEON/HK/+aMOd6
         87Qll45jko8fwcynw3zSafrwDo1KwXtt0aVP5McmDCJgJDzv1yxAFsmBRHPPDCuR/5
         SCOKroFpmns7CiMThpAtTEH8RiLJNJlmkrU9dSNBPLuiuRzE1CGQ4lx6HGKp52Q1/M
         BRWcJwf/3Qg8qGc6HfQtIRuOuhaRIal+ZOAL69ikSMMCwaAGGTm0/+6fcNh3m4OeFg
         xww/bK5y4RUn+89nKLMRMx9rbedjgU2Tn4+ByJWypv51YV7Zb5Poh3r9EbP3y3hLW0
         8Nwn8tKzSNJ0Q==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from tyr.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with SMTP id 8C2A8C01B;
        Sat,  9 Jan 2021 00:16:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1610147763; bh=EIJ3VFsukrboXt6dlSV6x9vCPLwaTFNwnBDwe0e29MA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yV6g5bexMO5FrJLLiz/eZhdNh1x37pn5Exnk/tpHMxDqb/RnGFoksOQYMlk7mSpeJ
         EcZ2s9CscKZZWQHkHZtHP+zqKwVO1u682vzlUt/GbTieZUN6isBJd7U2qu4Oh3FAxk
         mrsgVdrMj8WaRHyafIlIZGwEL5ujD95gZEhYtCUefK7b0lovU46dfVfN6Y6yQf+MmZ
         Behz+pz5ZdPKhZb0WOYeN2PCAXrM0NzASsVDLcdVPvTkDhnhLQDf2JE/qCxpUYx5mz
         OIJ8dbC14sB36IeQWINcAQ6X2qSmKyh7kXyC9Ml65R+mivWyW6N+S96jZPAvpt18Nn
         QClq5VEPlaYQw==
Received: (from asmadeus@codewreck.org)
        by tyr.codewreck.org (mini_sendmail/1.3.9 19Oct2015);
        Sat, 09 Jan 2021 08:16:00 JST
        (sender asmadeus@tyr.codewreck.org)
Date:   Sat, 9 Jan 2021 08:15:45 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     ric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: Constify static struct v9fs_attr_group
Message-ID: <20210108231545.GA42582@tyr>
References: <20210108224650.25872-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210108224650.25872-1-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rikard Falkeborn wrote on Fri, Jan 08, 2021 at 11:46:50PM +0100:
> The only usage of v9fs_attr_group is to pass its address to
> sysfs_create_group() and sysfs_create_group(), both which takes pointers
> to const struct attribute_group. Make it const to allow the compiler to
> put it in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Thanks, taking it.
-- 
Dominique
