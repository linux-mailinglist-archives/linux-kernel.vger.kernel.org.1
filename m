Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1AF2FFBB3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 05:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbhAVEWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 23:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbhAVEWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 23:22:23 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5583FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 20:21:43 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id i20so3935038otl.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 20:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rhsjamboree-org.20150623.gappssmtp.com; s=20150623;
        h=date:to:from:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=Ho9z8S53OW8n4I+jpe+fXoNReHcBDQuhBywXx2Dx3ww=;
        b=g2dHhp7Dx3ITACqLjpSMFYtq476mUnULgw/SGDteEXTqBeJ0NW8eXCQlSpv73YC1qz
         NqxUOWZQaDd4+dJtwr9HigKGi+/VLAoPv3EkAitF5DeQOWzHopATobXGzfroB4oTsCgx
         +45jBZDR0KFCldHiwJvrajHhy4FUQWfysDVnZMaK5XtCIkAcd1vl6SdVz/Qev4v6253M
         SXln6CyatxSEttoFCNPmLTiqgJuyguPnWaPAhQ0YrR//nx6dB5lUFJ1kbgXZiEfdSWwH
         9yo4GHUyvBpk2p33MffE/+GqtX2x76DjHeeF4UkIfhZCEj7jZlWvWAMU3RXG+TKPymZs
         5ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:to:from:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=Ho9z8S53OW8n4I+jpe+fXoNReHcBDQuhBywXx2Dx3ww=;
        b=NDzE4oKq52dnP06QRkD35qa1L8YTga0skGKQg/bVX4d0R7uAGMMYlaz2Ktngam9tSW
         UnwJt5wmBiEmN4m8ZGjdcymXGWuP+vjTIXeUXNMujjGPHODZhEBie0/jnw+3sGPLdpFc
         ey1fBn7Z0/ZR3KD+F7U3tsVuwyq+TFNNCfPBHbvoMb+hyiW5wD5Ogduv0NQTAqtQkj4q
         LBWi/l0IKcZmPnft177sFrCXdqR6AweoQlc9L0opW5m7auXviOhZORKMD3t7CDtZ3jGr
         6KXS2pKLYR4DEpJ6d2/eQtw6dgxBQgPJugT7je8gspqSq8LnvPMj8rMe/CimOUztEF85
         iUmg==
X-Gm-Message-State: AOAM530gP6L4QULAWBetQWaLF3etFG88/9XwRh4mTFDuAKL0UwHpKz8D
        S0/yqpNOVJLiNSP7xERlvbTPwA==
X-Google-Smtp-Source: ABdhPJxBqRqIsWAow87Rjl4pfzw/rPpEo4+OeXxZyN9H+6XDrSW0Mjvr2HK0LqSH3cDKviyPODSYUA==
X-Received: by 2002:a9d:5d1a:: with SMTP id b26mr2043700oti.112.1611289302698;
        Thu, 21 Jan 2021 20:21:42 -0800 (PST)
Received: from rhsjamboree.org (gator3233.hostgator.com. [198.57.247.197])
        by smtp.gmail.com with ESMTPSA id h11sm1447753ooj.36.2021.01.21.20.21.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 20:21:42 -0800 (PST)
Date:   Fri, 22 Jan 2021 04:21:41 +0000
To:     producers@rhsjamboree.org, linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?=E2=9D=A4=EF=B8=8F_Do_you_like_my_photos=3F_Click_here=3A_http=3A//bit=2Edo/fMQVV=3Fud7m_=E2=9D=A4=EF=B8=8F?= 
        <producers@rhsjamboree.org>
Subject: signup from website - backstage hero
Message-ID: <enHfZZn104ElD2ROOaxgrimk8nb4AdQfdMvNmK4ywNk@rhsjamboree.org>
X-Mailer: SAR Friendly SMTP 1.2.5 - WordPress Plugin
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ❤️ Do you like my photos? Click here: http://bit.do/fMQVV?ud7m ❤️, linux-kernel@vger.kernel.org, 436722671965
Subject: Backstage hero wants to help!


Message Body:
ihy5vra9

-- 
This e-mail was sent from the backstage hero contact form on RHS Jamboree (https://rhsjamboree.org/wp)

