Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8921629AE15
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368068AbgJ0N4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:56:31 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:47042 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368054AbgJ0N42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:56:28 -0400
Received: by mail-qt1-f178.google.com with SMTP id r8so977734qtp.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=eOpnKHC0aDqAtiwT/clJKqqj++9ewfmOSXLLZgoB00WbXkgBa9JykPceRgLP9r5WFh
         WxTYrgcF/hx/1xqO7G72hCz6hEQ4QJaA4VGMC9QCrnA6whNInIcAvjPi27Mvu+ocpozb
         fe7OstZqwqkwykjRwo4/CObftdYA0bLRxiREaP0h1eeB6s8coAKZ8lZG/Q6d6B2bEyRu
         AiC8Povu0WQMp019CRZmGmQ0su8k+U/tro1q2yRiTP6tJvEpKcNqZTT37YHc5jZ3y3q7
         4Q4XlOWmI0J83UU1bY/0lV+94Wu+wOFbnqOXSbHs8p+FV/ya72RluAC8SdSuzcucGJVG
         fsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=pn55q9l2csRwvlBpRhyx2ZMwmhbZVEOb3N/s2pGM+OSB9+Af4gGFFceRrAESmVO7Zm
         sb+HAPp3lRalT9YCNdfpZPW+jsLwGhL8UOGbppdKfkQI/93lM7EGraHpbcwLAUv9UMyh
         x+422WTD+zFMdS4+8DEap7I7go1NPvIDRiLMNc5A4J1AoRCu7IpQNs1bJTz2624lzFlH
         Ruf66Rx1D8DVG0Nnzu2dcohCG4cPxI3A4iMLmTu/DNXhSymIc1brP/fEvQeiS4dRLefN
         vhVfonYaIz1kPaGgiZtB1rM1MlePeczJ+qpJmUhSG5ly21PSCbATQRZ7tIiojykhLuFu
         dZAQ==
X-Gm-Message-State: AOAM530mPI3P8ZLLONVUG608SZmFuwHMfsJfGnO7xxSLLSxqv5zl+rrO
        +boW7YRqBNkv2dptJb8u5gayVIBXrx12TU/G0LUH6LMu0CcAIQ==
X-Google-Smtp-Source: ABdhPJwgX4ahuBhmq9OaHsAi8gl7RVYOD30LPwVT9eveNzoxwmaWuG9+cKD3Kl3m5P6iCUz6N7ZLo5MVnvu4YmOMVCQ=
X-Received: by 2002:ac8:7083:: with SMTP id y3mr2263549qto.248.1603806987139;
 Tue, 27 Oct 2020 06:56:27 -0700 (PDT)
MIME-Version: 1.0
From:   Long Chen <logicbaby@gmail.com>
Date:   Tue, 27 Oct 2020 21:56:15 +0800
Message-ID: <CAKAjjhBYxZFWMT0tqApF-DyEca_gAA=jq=EKhqt33k+oG6hahQ@mail.gmail.com>
Subject: 
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsubscribe linux-kernel
