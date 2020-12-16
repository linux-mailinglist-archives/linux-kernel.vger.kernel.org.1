Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF42DC89D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 23:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgLPWCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 17:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbgLPWCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:02:04 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CA0C06179C;
        Wed, 16 Dec 2020 14:01:24 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qw4so34924607ejb.12;
        Wed, 16 Dec 2020 14:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EiZS2jXqj3U/+bdFehgqn+1nrKy1cgYv0KO/vHHQS08=;
        b=cDRIqcZapUQGM4gSz/SBJ+14e98uEFBbn3SY+Xf0zqNnDvqwiV0d4JtnC5l8MrQHtF
         LG4JzeVu/7lvWH9aIvsXOAhTSSO5jVbaZZDkfV+yJAaw+pTsepydC2fEP+DqVERwlVKN
         M+MT/9cG18dRZbiUQJ+0BxWqlt6fJJCh8WRuqDoBtaZyiWAT8Umx1RCbbfvzs+vrjzw9
         dnp8eWMo4//2H851Vx2lk1A0Zx6FzWD8bHfavu+OSfBYHwmfTTl5yAaj5FLTDcDBnQ03
         pOcxhVQrI1X/TbAcamZzaq2KI7uDpD1ickvbEtyLbbwHYzfEWf/lG1+hugGPnIJ3EtJv
         Imog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EiZS2jXqj3U/+bdFehgqn+1nrKy1cgYv0KO/vHHQS08=;
        b=i0dxGxZLKDEDCi6dujYwpN/zQeBWk9hakAiSirOKAM/6yGeqCUUEj8no+/JJr9o+Uv
         I+MNnz+NmAHHmgCBg1WCKHSYY2U/KVyY4LNP49KpWpK6PcdCGADDtfubiqDXbN/lwbeK
         pEvAh67HdOUq6bF8QAcwsqKEnhZ4a0J6EDRQtuVkz1NEvDF/SkYB1m0EMFDxArEGBf99
         19twoF96GqST/itRmbIuEpUMgYrLjJteuOA8SYZ5+VKQyLUPxBBHfN5+nHxZ+ySvHd9W
         HQvEyNNu8Addd545TJkGOIDjBoBkaDvyo12rmS61LrN5rnorvxragZxAlEQbZrqmw8dB
         NSuA==
X-Gm-Message-State: AOAM5306Uz65UccpVctyLYL/rwu0iKb8qFHAcWa34mW64o8kYQuMfjsL
        m5nVcn/J/qN3yEyX3aoszwE=
X-Google-Smtp-Source: ABdhPJyiDZru9D09+aCuFMyDiW6uun0k5DawczBTTUZkhfU5NzuGcWMPJIulKg1St7zcjEvrlls2LQ==
X-Received: by 2002:a17:906:aec6:: with SMTP id me6mr13935125ejb.542.1608156082817;
        Wed, 16 Dec 2020 14:01:22 -0800 (PST)
Received: from localhost (ip1f10d3e8.dynamic.kabel-deutschland.de. [31.16.211.232])
        by smtp.gmail.com with ESMTPSA id bq20sm2316995ejb.64.2020.12.16.14.01.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 14:01:21 -0800 (PST)
Date:   Wed, 16 Dec 2020 23:01:10 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     konstantin@linuxfoundation.org
Cc:     corbet@lwn.net, miguel.ojeda.sandonis@gmail.com,
        grandmaster@al2klimov.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: PGP pathfinder service is no longer maintained
Message-ID: <20201216220110.GA12262@ripley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Unfortunately the site https://pgp.cs.uu.nl/ is not maintained anymore
and the "Finding paths to Linus" link in the Kernel Maintainer PGP guide
is dead. Is there any alternative sites to find a way through the web of
trust?

Best Regards,

Oliver
