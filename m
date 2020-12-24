Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6802E23A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 03:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgLXCWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 21:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgLXCWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 21:22:46 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874F2C061794;
        Wed, 23 Dec 2020 18:22:06 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ce23so1633981ejb.8;
        Wed, 23 Dec 2020 18:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YiPNSwxAjPo4uUXcm83X8w/z0y2D2T2Z9dm6l7uYvao=;
        b=DLBLiViEgeQx6WaK8axjfeKuOHTdltdswEpEWaZTLKbgaE8nA8iAlDwJqla75RnF5/
         9vsiiySsNawQ8DoxRdfXn0/e0wTZyj9macFF4PUJ6PauHrmm53rVqE8u20BpjpzFxxX/
         QHMvy8JhWEwrwIYtsh7/98jYy2OrUUmkK1MRvhsx0ba0/fWEA0tEaQT4RoCTJzPRRwUj
         Na8YrF3yRqhTAokSWrt6PgkKLiK+WQfPGwGUfe+ELs1qS/uQyrXxOZvgFl0+zP2rKW4P
         FJ2caBkhZD2JPnBcOajNAiGgE/yy7Rht3jA5pUAvrGfYkGfpZlx91JbIiDwHX+GtZlPm
         7srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YiPNSwxAjPo4uUXcm83X8w/z0y2D2T2Z9dm6l7uYvao=;
        b=HSPGbSeGgBgmZvFdOon3tcYZ14CHfxVdfD7fKdGx2ElLSgl3LrTalXxJDFCnP/WahZ
         XmdXQbapVj+/FKJIcENnJwABWh7HDefXhNRdtPcbmWZdFD9lyYwM/onjoOPAP7pqa8Mh
         fFksI0jxJgCM/VOMj9z/C6DjjWznF7wEyy90dmFGm2XYjOIONSsUAqyx8KozLY//dKw8
         1WN6re7TxUtLu6Yyr6Jl+DkzUy524/1z0vxJhmbstqxlgsdxM+58k+2Ulwv97CrDYxad
         EQ4u8TPwMe7GbOJEKSpgYzPo93A4+pSe3M5rEoihRlacA1YtsB7CpSQsF0dUf/nrcutg
         R2VA==
X-Gm-Message-State: AOAM532EHe9TWTli+WRU9EtzxfmtuhLBFg6JiXOfhTXeasf0uUYhbmN7
        HdE6uaAa1NCgFB9/BWj1gLW/B1CU9p63RItYHQs=
X-Google-Smtp-Source: ABdhPJwLwjzHJ9C9lV1ZFjokYjldXjo0uBAvL6v4MJ3Kvy5Z0L+8fkp1ZGrRNrw9V0BBhIAd2E1Hdb5EIyxBpLCRvFI=
X-Received: by 2002:a17:906:7804:: with SMTP id u4mr13377125ejm.97.1608776525300;
 Wed, 23 Dec 2020 18:22:05 -0800 (PST)
MIME-Version: 1.0
References: <20200922091505.471-1-zhenzhong.duan@gmail.com>
 <20200922162901.GA3421308@ZenIV.linux.org.uk> <CAJF2gTSMWc_=j1NKCTXqhLj7cmSB_A3dYB7nL4F7H3jqT+u38A@mail.gmail.com>
 <20200923002315.GC3421308@ZenIV.linux.org.uk> <CAJF2gTSU4e4yU63z1q502SeuTf2m2BKaD0yZ0deFj0TkiVupFg@mail.gmail.com>
 <20200923045231.GH3421308@ZenIV.linux.org.uk> <CAFH1YnNwqrK+kHbLKH684AwPWM0TfOxKC37TfJe5FYZ4_AXRvA@mail.gmail.com>
 <CAJF2gTTeqm7=NaUzSQ8NfJwvo8hNrHtkLx7rwyZE5FdmLL7+tw@mail.gmail.com>
In-Reply-To: <CAJF2gTTeqm7=NaUzSQ8NfJwvo8hNrHtkLx7rwyZE5FdmLL7+tw@mail.gmail.com>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Thu, 24 Dec 2020 10:21:54 +0800
Message-ID: <CAFH1YnPNXcwr+wekLaXjt3AzyOvywb6+fa7--=zQFxaVCzw1uw@mail.gmail.com>
Subject: Re: [PATCH] csky: Fix a size determination in gpr_get()
To:     Guo Ren <guoren@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 10:57 PM Guo Ren <guoren@kernel.org> wrote:
>
> Hi Zhengzhong,
>
> I'll take it, thx.

Thanks Guo.

Zhenzhong
