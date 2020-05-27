Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60391E4368
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 15:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgE0NUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 09:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0NUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:20:22 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C50C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:20:22 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id h21so28076485ejq.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vqFiBOeL29zCvVHr60bFoTtjn/3swasirJGUWjyvqms=;
        b=iSBOOJFaTXIcuaop9W4oX2oFht6bVK+icOxVe6Y+sVbLm12TWu0U7G+9WDhNmn8YPQ
         9WPoTUiVp9i7hAz3F2xA8NQmhtrVV6/LoXi5nSak4ZkFaIZ/o6lSgcVFwXbuiyIAfj1s
         NCexrElQ4CDyhZPIdVn5iXM3xnC9D0YhSMHAaNUY5y2tdCSk6XOb4xSEHX/sSi4jOJHo
         ssS03D9yMMC+VyVDw3YHEdQVpVhjsH+Gma3oH1q0Shd2Hpjb46k2EnX0HSS+L+tAj4YO
         67/4p6XO8wqmsOVvPvBGZHK6eT7mL9sCoQXxVe4fFg0Xfz/6m0VfHqXLOl3AC8Ruw+OY
         zk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=vqFiBOeL29zCvVHr60bFoTtjn/3swasirJGUWjyvqms=;
        b=ZqUGkzMFpcGrw4QFXofqUaMvnlMwKe8hjnxaJ6xgH1E8YZEHk9FBHslSqx4TGSmwDA
         RgGV/yHhQ5aJK7BYDdRtunJjcJ0/KPEk1+K8U4b5LSVNMj35P2RQo4cdHPPY2QWXPvs7
         KXx2PK0erNaRFaUFgedR828iGjOz8z23FyMY86RTkqaKgurReDpksRgXq0edDFl3z1dg
         W3EywRiReb4S/b3aPgdkAW3Qf7jHcISmRwhJrPqkOnVrUy8oWhf8gsE1apQx2HGvm9ea
         z0Bvu77xBnDW1K97rjV7Ot96RinBxe90XIIqNl0PjgcNQMgz7bQX+En7xZK7NI2RsJhD
         lP7Q==
X-Gm-Message-State: AOAM530a7kDrgF5469ZwdfJDREITh94mh6MpwZV3nV7Vpo9wcYGCaTUQ
        OFp0Nxo+mk+1sy72m+8LnXhHqmV8A64heE+dpvE=
X-Google-Smtp-Source: ABdhPJyaOGG2D/RHbZ1yt/exPnksFGBDc2tL4EJrStFzp9RfhPKyqgiytRmDvkZWkF1YAJPuvzxyNBb/jkDeZstG2Ik=
X-Received: by 2002:a17:906:6bc5:: with SMTP id t5mr5927199ejs.459.1590585621013;
 Wed, 27 May 2020 06:20:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:2d06:0:0:0:0:0 with HTTP; Wed, 27 May 2020 06:20:20
 -0700 (PDT)
Reply-To: kristiandaniels59@yahoo.com
From:   Kristian Daniels <crenetogo2@gmail.com>
Date:   Wed, 27 May 2020 06:20:20 -0700
Message-ID: <CAG+0+mTdsYpQvHui+n_hBK4EEYszCoUaOj3fUFv=MdQ2p_gmJg@mail.gmail.com>
Subject: =?UTF-8?B?0JfQtNGA0LDQstC10LnRgtC1?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0JfQtNGA0LDQstC10LnRgtC1DQoNCtCQ0Lcg0YHRitC8INCzLdC9INCa0YDQuNGB0YLQuNCw0L0g
0JTQsNC90LjQtdC70YEg0L7RgiDQo9C10LvRgSwg0YDQsNCx0L7RgtGPINGC0YPQuiDQsiDQm9C+
0LzQtSwg0YEgQS5ELkItVE9HTy4NCtCY0LzQsNC80LUg0L/QvtGH0LjQvdCw0Lsg0LfQsNC60YrR
gdC90Y/QuyDQutC70LjQtdC90YIsINC60L7QudGC0L4g0YHQu9GD0YfQsNC50L3QviDRgdC/0L7Q
tNC10LvRjyDQtdC00L3QviDQuCDRgdGK0YnQvg0K0YTQsNC80LjQu9C90L4g0LjQvNC1INGBINCy
0LDRgSDQuCDQstGB0LjRh9C60Lgg0L3QtdCz0L7QstC4INC00L7QutGD0LzQtdC90YLQuCDQvdCw
INGF0LDRgNGC0LjRjyDQutCw0YLQvg0K0L7RgtC90L7RgdC40YLQtdC70L3QuCwg0KLQvtC5INC+
0YHRgtCw0LLQuCDQsiDQsdCw0L3QutCw0YLQsCDQvtCz0YDQvtC80L3QsCDRgdGD0LzQsCDQvdCw
INGB0YLQvtC50L3QvtGB0YIgMiw5INC80LjQu9C40L7QvdCwDQrQtNC+0LvQsNGA0LAsINC60L7R
j9GC0L4g0L7RgdGC0LDQstCwINC90LXQv9C+0LjRgdC60LDQvdCwLg0KDQrQntGC0LPQvtCy0L7R
gCDQt9CwINC/0YDQvtC40LfQstC+0LTRgdGC0LLQvi4NCg0K0JMt0L0g0JrRgNC40YHRgtC40LDQ
vSDQlNCw0L3QuNC10LvRgQ0K
