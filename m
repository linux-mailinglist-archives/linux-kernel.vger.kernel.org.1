Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2078E2F7893
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbhAOMRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:17:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727974AbhAOMQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610712932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=HAV4RtXan4evC5s/n+2403kxkMSlPpWaF/xBVJ3pEEwyHBptZ6W0SlEDoAPjlH+3FByV4f
        zv2/xRHDTkqdOZ38OQgRYzhES1T3TkRSVf6OvWak8yPQkJTA8wnZskqwOuTctrYNTvv4Kw
        D0/kNW33nem8iwSrBgDauo/1BHOIU9A=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-BsYEukCsMB2iGjKfjccWsw-1; Fri, 15 Jan 2021 07:15:31 -0500
X-MC-Unique: BsYEukCsMB2iGjKfjccWsw-1
Received: by mail-lf1-f70.google.com with SMTP id x186so3054446lff.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=ulkQv6oLL2XviFssrsOfXJK7oTR4E0bLvnmVy0ZOi4Z4P5H6ZcnCiYzqyMctfTSDYB
         G9hvppWIyoanAXTDI6/o4auNDjhdVvuM7M5oCCcQJT7Jt10+RyB0pHtq3IjAV5DnxGgZ
         fbqMV3GS5WaD3eaOcAgMpitC1k5nmlhxrcq+Vc+cuOWADR3szYGWbJsr2r3mVCDqiP2r
         heA1M2bX6MH1Hpw8R2MbK3KeYdKDSazM9DTF31IlRWEnsRI5X0gn0MoqpkxWiFTqYmSj
         vIUCJzRhgaCRFfPAoZuQqyA5EW8l97/AnDF+wc0uU32FV0V1YpSut0WQzpoBh4ai0MFo
         UejA==
X-Gm-Message-State: AOAM5323OuVfDyq3DmvgF7g76OdaeKaU8GG1QihE+bFJxZF0cT9gy0wa
        ZCSCkZKzrCcwkQFvzSRBTEu8TLQFqye11p1ltSrVnqaEDgXDqeCV9H39y7ILAKDe4qRAeUNQFtL
        Nu6+J+C8MCm1PuygVkyHEmBFwNAzW9qJ2fjhzhv1S
X-Received: by 2002:ac2:483b:: with SMTP id 27mr5482831lft.429.1610712929403;
        Fri, 15 Jan 2021 04:15:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMBEqGna8ZDchAcRK8paCfuWBZ1xFRtt9cOFyoGl0Ju6VcIhVOVdtsBA+albHyrCaZ78Pzbi00pFMfEdmQAE0=
X-Received: by 2002:ac2:483b:: with SMTP id 27mr5482824lft.429.1610712929232;
 Fri, 15 Jan 2021 04:15:29 -0800 (PST)
MIME-Version: 1.0
From:   Nitin Yewale <nyewale@redhat.com>
Date:   Fri, 15 Jan 2021 17:45:13 +0530
Message-ID: <CACgRdrbYbZqDboFa5FiRTDvZ165z1j5DPXd1sf8+hM1yJeKRDQ@mail.gmail.com>
Subject: 
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsubscribe

