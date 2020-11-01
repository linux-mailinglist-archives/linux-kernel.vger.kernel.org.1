Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228982A1F76
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 17:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgKAQSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 11:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgKAQSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 11:18:49 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB711C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 08:18:49 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id s14so9449992qkg.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 08:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:message-id:date:subject
         :to;
        bh=uoULYXfmfsYvZeTl2rSN1/TVjepk39OejLyjg4WnFN0=;
        b=bgsofOf/t/8QOWBDaaKcgckLD9+lhjmZ1zjI1B7kyjVdqqfrYEf6xDL5EyZoyGn/lN
         I2xc/q9IFkJMScILayUr5OWSfEapdoI74GRZ6lBxOXIX58bcbNolQYqDQQLW+hR2gprT
         14t4WndkfNMn14vfCP51qmrsxPvEuQ7/xg7pdYOaM13OTpe1WsLsNRL24WB9EdnsJ3n2
         wlO0ZDK8PK2ogtBEql6PI5sUXjcLLOaZ80r+pvrlK3OZwSe+aRKa6UOAEitkUvV+bLmz
         HFsrHAYeH5LaUuw3MConIAHrABpTD/Dr328c/gWKiA5pC7UgTvi+E4gg/9sY0F4KnCh+
         TppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :message-id:date:subject:to;
        bh=uoULYXfmfsYvZeTl2rSN1/TVjepk39OejLyjg4WnFN0=;
        b=gTR5fhDOBdTZiJp2Pdj3VuYB5meV3AjnGURoIWmg3CR0w9WQsMEO7i6DZIs967h+7X
         T0hcYBtc96hEExNbGWsW6K2s1OtgecQnsPG4Qrf4wmX+lgTQSN1G5cxQQT1BWdFd6bWo
         +5oqkEgRhckpdYAjSNwCNuwTqxyqa6OahxQ53P/xmyeaBImisVraJpIj08UO/Fry0smR
         fVc1UY//mNsP5cd09awIV4sdxgJJkhkFyLXj2MWa73gZlVEM4xcNqUdZAGHuvDjDdlCd
         pvCjbMxxpc66kT6a7NoXALs4Ywz/iu1Fu8EqKBOztobMFXLfU//CfuRhxa1sfsSJl0WJ
         StIw==
X-Gm-Message-State: AOAM530mUBpl9+EbzUHytCg89BbwAgOgV2hmMG0Qt/621lMpJU7XEwr7
        ZgwFV7hBIdRr9XQkbpk6asjMBKTPuxOpww==
X-Google-Smtp-Source: ABdhPJySdhbXddguJ5wxnM5k4P9OYavIvWI9kf60EqKErf9j4MjZPhUhSIF3Z2/sEwE4f9HArWfheg==
X-Received: by 2002:ae9:ea18:: with SMTP id f24mr10855507qkg.135.1604247528730;
        Sun, 01 Nov 2020 08:18:48 -0800 (PST)
Received: from [10.200.10.3] ([114.141.194.12])
        by smtp.gmail.com with ESMTPSA id z69sm6220858qkb.7.2020.11.01.08.18.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2020 08:18:48 -0800 (PST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
        charset=utf-8
From:   NASA Jeff <tallboy258@gmail.com>
Mime-Version: 1.0 (1.0)
Received: from [10.200.10.20] ([114.141.194.12]) by smtp.gmail.com with ESMTPSA id f77sm4564212ilf.40.2020.10.29.21.20.25 for <linux-kernel@vger.kernel.org> (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128); Thu, 29 Oct 2020 21:20:31 -0700 (PDT)
Message-Id: <E610DA41-447A-46DC-A38E-C1EEEA8F44BD@gmail.com>
Date:   Sun, 1 Nov 2020 16:18:42 +0000
X-Mailer: iPhone Mail (16G201)
Subject: One note
To:     linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages in active areas shouldn=E2=80=99t be swapped out only those in inactiv=
e areas. So it=E2=80=99s a bit like seminary rock.

Sent from my iPhone=
