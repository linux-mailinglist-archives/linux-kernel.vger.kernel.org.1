Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D761EF5ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 12:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgFEK57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 06:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgFEK56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:57:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DE3C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 03:57:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o6so5002393pgh.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 03:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=sVz2aLLwBID+iNXxaxK8NNC/XEAYEulMMbbaVMsRreADaF1S67RdWnNFwz2Cs2daig
         AEIQ7qaxE0RZL0/V96vHxE6I4m3pLnimk+dTo5QXX9JS5K8V72cwEvQyqjn7kebJhu2E
         9XTDLV6uOz1p2cm4o1uVSa2z4Pec0fSIpuy3vUMg/APCyEO/1g0wzMaBIG68KBxTaWMY
         Weg0F/WB+QsM2MrKk6pvIamcyIVzfQw+v4fSsMe1Xfn+Y7bfu9eFWEASj3+dNi1WSqjs
         Hd1zBekeFfwmJhrgAXNrYBxS5ryoYE/H88fOgV3ThRkOxq/e+LUGX2GBRc+vY5yNmBn1
         IUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=k3BgygBUVH+6WWwMSErQTfKZJPyqTGL40IaWQ4yzuPkrvPIPvjMesq8kHSzPTm/XGQ
         b0brICelXCHZpWfdQK/IDN8KYBbFXHX5FvFEvW50aVnKVtTyXicvS3ferCFiM9TM6MEG
         uVnmymG3/WXLR7Q/YcWChshlO0LUI1bY9yfgadIcWzONebnLdxABe5qTw4IqOWX325st
         CRruykuqI3gsnORPNJydk78OUd83ZxfoQVufdej7QzPY36GeXuzUya6tS+92Qe8sELR/
         XOg8nYVCaNQBPQdsDCDYjAHIIrOyzVTOHVV4PHkyZ7gQoMjBB+pJcKfvzjf4QW3RpJN+
         /5qA==
X-Gm-Message-State: AOAM530HpDOjj7dVkympoKEJZuaOHW3+xj0hppgq8Fwca2OBndoyeF7n
        Idqr+5rg62/Kw0alu3VTrr4p2gFNcuGSTOkVpsc=
X-Google-Smtp-Source: ABdhPJxC7f8Q28CW/vY1Xuhu5hofpnZmTYeAdPKy/yeq8/Vzy7zl0Cacd55dkLUzW/a76JNYtclRRjtMs5hex2mm+5M=
X-Received: by 2002:a63:af02:: with SMTP id w2mr8706580pge.116.1591354677443;
 Fri, 05 Jun 2020 03:57:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2751:0:0:0:0 with HTTP; Fri, 5 Jun 2020 03:57:56
 -0700 (PDT)
Reply-To: robertandersonhappy1@gmail.com
From:   robert <afameoknieke@gmail.com>
Date:   Fri, 5 Jun 2020 03:57:56 -0700
Message-ID: <CAFC1G9khYYaUmbTimmoLbOqOjaDDuGgKVWsjjz7j-X+G7SaqhQ@mail.gmail.com>
Subject: =?UTF-8?B?0JTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsINCc0LXQvdGPINC30L7QstGD0YIg0JHQsNGA?=
        =?UTF-8?B?0YDQvtCx0LXRgNGCINCQ0L3QtNC10YDRgdC+0L0uINCvINCw0LTQstC+0LrQsNGCINC4INGH0LDRgdGC?=
        =?UTF-8?B?0L3Ri9C5INC80LXQvdC10LTQttC10YAg0L/QviDRgNCw0LHQvtGC0LUg0YEg0LrQu9C40LXQvdGC0LA=?=
        =?UTF-8?B?0LzQuCDQv9C+0LrQvtC50L3QvtC80YMg0LrQu9C40LXQvdGC0YMuINCSIDIwMTUg0LPQvtC00YMg0Lw=?=
        =?UTF-8?B?0L7QuSDQutC70LjQtdC90YIg0L/QviDQuNC80LXQvdC4INCc0LjRgdGC0LXRgCDQmtCw0YDQu9C+0YEs?=
        =?UTF-8?B?INGB0LrQvtC90YfQsNC70YHRjywg0L/RgNC40YfQuNC90LAsINC/0L4g0LrQvtGC0L7RgNC+0Lkg0Y8g?=
        =?UTF-8?B?0YHQstGP0LfQsNC70YHRjyDRgSDQstCw0LzQuCwg0L/QvtGC0L7QvNGDINGH0YLQviDQstGLINC90L4=?=
        =?UTF-8?B?0YHQuNGC0LUg0YLRgyDQttC1INGE0LDQvNC40LvQuNGOINGBINGD0LzQtdGA0YjQuNC8LCDQuCDRjyA=?=
        =?UTF-8?B?0LzQvtCz0YMg0L/RgNC10LTRgdGC0LDQstC40YLRjCDQstCw0YEg0LrQsNC6INCx0LXQvdC10YTQuNGG?=
        =?UTF-8?B?0LjQsNGA0LAg0Lgg0LHQu9C40LbQsNC50YjQuNGFINGA0L7QtNGB0YLQstC10L3QvdC40LrQvtCyINCy?=
        =?UTF-8?B?INC80L7QuCDRgdGA0LXQtNGB0YLQstCwINC/0L7QutC+0LnQvdC+0LPQviDQutC70LjQtdC90YLQsCwg?=
        =?UTF-8?B?0YLQviDQstGLINCx0YPQtNC10YLQtSDRgdGC0L7Rj9GC0Ywg0LrQsNC6INC10LPQviDQsdC70LjQttCw?=
        =?UTF-8?B?0LnRiNC40LUg0YDQvtC00YHRgtCy0LXQvdC90LjQutC4INC4INGC0YDQtdCx0L7QstCw0YLRjCDRgdGA?=
        =?UTF-8?B?0LXQtNGB0YLQstCwLiDQvtGB0YLQsNCy0LjQsiDQtNC10L3RjNCz0Lgg0L3QsNGB0LvQtdC00YHRgtCy?=
        =?UTF-8?B?0L4g0YHQtdC80Lgg0LzQuNC70LvQuNC+0L3QvtCyINC/0Y/RgtC40YHQvtGCINGC0YvRgdGP0Ycg0LQ=?=
        =?UTF-8?B?0L7Qu9C70LDRgNC+0LIg0KHQqNCQINCU0L7Qu9C70LDRgNGLICg3LDUwMCwwMDAsMDAg0LTQvtC70Ls=?=
        =?UTF-8?B?0LDRgNC+0LIg0KHQqNCQKS4g0JzQvtC5INC/0L7QutC+0LnQvdGL0Lkg0LrQu9C40LXQve+/vQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


