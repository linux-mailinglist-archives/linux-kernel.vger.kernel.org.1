Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0C12D586C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgLJKlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387954AbgLJKki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:40:38 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F612C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:39:56 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id u21so3242847qtw.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2WFU4dR05ZGB+4ahSYpvkou90km6wj3qFHGpNOIG9M=;
        b=ZCaNzYwl7SUQuyXA717WC7IZendW6N96htJ/gjKsEIGCoZB1Ol2tjYR06fRUijr3FA
         5ISU/OS7u1Az8OZW/eMNZ9OyMnXLIt3fQebq1fqezHuUQvqK9+KckKMwxfVmd83nO9V/
         Kx92pP+6KrpJnV69lBueCksEBq0CNg/B/GMhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2WFU4dR05ZGB+4ahSYpvkou90km6wj3qFHGpNOIG9M=;
        b=sRi/J34KJrtOLniANqgQb7n739jYtEG5QV8jtcqWRNDVZWdkIl0EHRBX3QIQJ/Q0eJ
         avxgioAWqmZKpd0YgsTzmqHjL8mEIO2HyXGXLAlTSFRjsH2UqpmcQ8nemSza6+sBXZu3
         IgPgf/e1+sub/8XnRA69loaj7UNb9fd4l0p+qSxzQe0heCVr3I8tnGNNzhFg9gwn9Ab3
         HXiWZXismfzvqYioUVQdHQzzAjfPCCjhGn1PLP/R8wHhHK3TDbYAKQTnxGPoc5m4B4YE
         ACkGcP7/85toB+DYTvVgtGz/owfOna3T4njelRSJU9wFYcayM4IMCPZhNnTIh8RggMj6
         6B0w==
X-Gm-Message-State: AOAM5311Pe3YEI/R2Gfteo2/fVYw91KnrfB+kQenCEk2lr2cAP8NiMUK
        Hz5PEopVhpBW56hdckPAzYPdcylr+aU41fHKT9JgBw==
X-Google-Smtp-Source: ABdhPJza71bHTJCiyvRTTQ2YNcpXeu9wyUFDyS+bpZT9AnvgoplhU3GXEc+KIUKkz1TdBEplvPh0gJR6E49WgL8pWZg=
X-Received: by 2002:ac8:5647:: with SMTP id 7mr8312313qtt.148.1607596795854;
 Thu, 10 Dec 2020 02:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20201201134330.3037007-1-daniel@0x0f.com> <20201201134330.3037007-3-daniel@0x0f.com>
 <20201209163409.GA566058@robh.at.kernel.org>
In-Reply-To: <20201209163409.GA566058@robh.at.kernel.org>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 10 Dec 2020 19:39:45 +0900
Message-ID: <CAFr9PXmwOEuHHA-kDeL1YS8bWvovrt43MXxyy1J+hGbXwPUFSA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] dt-bindings: vendor-prefixes: Add honestar
 vendor prefix
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>, SoC Team <soc@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        olof@lixom.net, Arnd Bergmann <arnd@arndb.de>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, 10 Dec 2020 at 01:34, Rob Herring <robh@kernel.org> wrote:
> > +  "^honestar,.*":
> > +    description: Honestar Technologies Co., Ltd.
>
> Alphabetical order please.

Sorry about that. I intended to do that but apparently don't know the
alphabet anymore..

Thanks,

Daniel
