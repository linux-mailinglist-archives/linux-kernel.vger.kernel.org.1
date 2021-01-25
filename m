Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7433024D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 13:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbhAYMRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 07:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbhAYMNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:13:19 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA3EC061222
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 04:12:37 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gx5so17645260ejb.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 04:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sELvWNgnEJ2MVJqszYv1Ml6/L5kE+VKrd2/mLj0kl5U=;
        b=CCS4dJURoGOrE0h2rv0bJxwpFJJixsR6978hUFo00+DEnTFfi5sMh52x+Bv7iTQ0We
         sYiUlZDfI5b79VtMtFsyxivWncmU7KNGNU8i8AUeJ5P8BbabR7CX84tY6xlVIkAZJ/q9
         1BbJXzv/wyJCozVh9cAs5WmB9F1Wcf2ns2bNlWn1zmMWGr5Dh4+xKUJ8kyAi+H7f0JCp
         STTiUICH/5w26vxtguyNsUQ4aFMzSNS5CYuuVbs1qRXDHZopMOg2RbWPtMbG55LC8iuG
         Hfxh//dL5FqAWwi/lIu6JNxknA+fBFk9nYiTKMLpM1U68mxFxkXhlL4seeZuQvBdMMgS
         EzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sELvWNgnEJ2MVJqszYv1Ml6/L5kE+VKrd2/mLj0kl5U=;
        b=GFOPhARtJte05anhiN57hOt49D+of3FS67NcM/pnk+ueRtOJEPQAr2rD5vie0j4PTf
         nncbo5HFhl+RN4N+6m28+qkhI4IPFDz6AvZgx3SjMcUkrBOwkIK//X3yJlwsSHVbfqqb
         JrsuZbI9hkwcmDaHqnt0t6KB2SE6RlWiIxodyjmZK+DKQdxbQBn223aCHbO6UfTBsJeO
         db6xxGaJIXDm9kcEtFx3UcMSNePUIZmKGEpnEhtGbI4DkoB1Gf7XrCNmLNbjlwlUqocp
         VZyHolEioy4cCVYAsarhBTKGrp9Wf5BXNYCw6yl/Z/BscjTcBWSgBXH3AVKSGm918Fqw
         yTCg==
X-Gm-Message-State: AOAM530wmV2dhwbwIHWAWGCuODT/r3wHweSqeYt9wXUep6oFdbWb6aYP
        fmd6B+xmBPLkl0pls85J6zMJsg==
X-Google-Smtp-Source: ABdhPJzqsThtQLrvLlbaEj1Eg+JDSFaICmXN85M0CcNQJa6yi+OZXuKJQ/YkVMmXd+7B4xVGeU0IJg==
X-Received: by 2002:a17:906:b0c2:: with SMTP id bk2mr165558ejb.223.1611576756151;
        Mon, 25 Jan 2021 04:12:36 -0800 (PST)
Received: from localhost ([85.163.43.78])
        by smtp.gmail.com with ESMTPSA id p21sm10330901edx.90.2021.01.25.04.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 04:12:35 -0800 (PST)
Date:   Mon, 25 Jan 2021 13:12:34 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Ido Schimmel <idosch@idosch.org>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        netdev@vger.kernel.org, jiri@nvidia.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: core: devlink: add new trap action
 HARD_DROP
Message-ID: <20210125121234.GJ3565223@nanopsycho.orion>
References: <20210121112937.30989-1-oleksandr.mazur@plvision.eu>
 <20210121122152.GA2647590@shredder.lan>
 <20210121093605.49ba26ba@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121093605.49ba26ba@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jan 21, 2021 at 06:36:05PM CET, kuba@kernel.org wrote:
>On Thu, 21 Jan 2021 14:21:52 +0200 Ido Schimmel wrote:
>> On Thu, Jan 21, 2021 at 01:29:37PM +0200, Oleksandr Mazur wrote:
>> > Add new trap action HARD_DROP, which can be used by the
>> > drivers to register traps, where it's impossible to get
>> > packet reported to the devlink subsystem by the device
>> > driver, because it's impossible to retrieve dropped packet
>> > from the device itself.
>> > In order to use this action, driver must also register
>> > additional devlink operation - callback that is used
>> > to retrieve number of packets that have been dropped by
>> > the device.  
>> 
>> Are these global statistics about number of packets the hardware dropped
>> for a specific reason or are these per-port statistics?
>> 
>> It's a creative use of devlink-trap interface, but I think it makes
>> sense. Better to re-use an existing interface than creating yet another
>> one.
>
>Not sure if I agree, if we can't trap why is it a trap?
>It's just a counter.

+1
