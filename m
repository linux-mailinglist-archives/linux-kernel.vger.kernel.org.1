Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8690E2B7350
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 01:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgKRAok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 19:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKRAoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 19:44:39 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FF2C061A48
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:44:39 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id d9so187374qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvMBZnCEU5HoaKmEz2zC68vpae0VCPnCFkIIwIpMjCk=;
        b=Er5jrtRz40N9KHFqK3cRPXgMF0i3IBbwmRk6dSn01KOUDUMfMTesxKstZ/Dt5cFXna
         1ZODWfd4S/lLnDugAhoeyPGWx9DNNOmwlkugIsswm2gaqJQdKTFkIQHf8slWLj2I/3l4
         KlgtE1QD1Td96KeLNBs3ojUC9Ch/qfH1Dd3wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvMBZnCEU5HoaKmEz2zC68vpae0VCPnCFkIIwIpMjCk=;
        b=ZrPYM1CpVVovIj9wGgdy62oFEupW65fb1t5fV6AebcAdxurYqH0mbljyclXn6O1T8y
         oT/4dOdDY5/ooOJBIdUBreu0l88VxZfth0i7gh3+xgGAKi+CjNpxNjVa6cFhgdZQPoih
         lFO880Y9plgWuUIFg0UrSgCLF6/eDeRqE+xTQVMMULiwPA1EdSHd9qppeM+K+kGJ6btY
         YV/NGYno3RIgLxGatQMWhSnYGwepTPdUInzZBq9EsrJ6cuUDMUEj/q5Prhvjkljb3RWr
         +Lo5hv1Yprc6VF3s1TDl5j1mg7EsOq0bUAfw1paTdMukbDLEj52aPToRkeNm31NjBMps
         QpdQ==
X-Gm-Message-State: AOAM532wHoja67n6t4Kq5MU/kS1WBi/TJaxXCk57gq3cAplmO48yX/l8
        hDQcFhElvOOaxbxI95qc94z24f2TEd8qWM1falJerQ==
X-Google-Smtp-Source: ABdhPJwdlObKSjwaCKGeUXkqhAFPM3jkFlTSb1KkSlXnuE9weNacpVZAv3k/Wz1OebvdaRrbgz0pjZ92COdoUXuvGzc=
X-Received: by 2002:a05:620a:6d4:: with SMTP id 20mr2477398qky.4.1605660278520;
 Tue, 17 Nov 2020 16:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-6-utkarsh.h.patel@intel.com> <20201117211619.GD1819103@google.com>
In-Reply-To: <20201117211619.GD1819103@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 17 Nov 2020 16:44:27 -0800
Message-ID: <CACeCKaf6ErEdzcWAXU_1ES63za8GunFgWfOnhiJOowY3iYA6UQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] usb: typec: Use Thunderbolt 3 cable discover mode
 VDO in Enter_USB message
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 1:16 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Utkarsh,
>
> On Fri, Nov 13, 2020 at 12:25:00PM -0800, Utkarsh Patel wrote:
> > USB4 also uses same cable properties as Thunderbolt 3 so use Thunderbolt 3
> > cable discover mode VDO to fill details such as active cable plug link
> > training and cable rounded support.

On digging into the Cros EC code further, sounds like active cable
link training and cable rounded are necessarily only part of
cables that have a TBT cable VDO, so sounds like the approach in the
patch is fine.

Sorry for the noise.

Best regards,

-Prashant
