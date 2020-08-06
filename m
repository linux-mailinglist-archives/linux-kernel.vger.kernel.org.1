Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EBF23DE92
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 19:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgHFR13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 13:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbgHFRBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:01:33 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20836C0A8883
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 07:20:23 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x24so8878159lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 07:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hhhap6Yc7PpUiUD0py8cHrVh0mhGyr2EPQNKI0dXDKo=;
        b=P8YzW7gcNiZLomPm4YW7RgSSI1+6vb2MSMdmbioBbs3SF3p7ki3QgaxwMkghJG2ztj
         jmw5b9dgPywgQugwKpQbk/Snks/TAi8gXAujjkqCiTZsxpUnPiQKCE71qctiPc0zh3u5
         Tl/G21sV0TIvXSBzARChQCZxZ2d74692f5bKo3VNkm06tLBdPTF87BJtnhIRhrYuwlLg
         6ss7enUZK0GtY/R00vdeo1tJqxyAyoCCfa4/Gx/yFcSJk7SuVo/vS9LGTmDNbigc7sqJ
         VgjicOqXTRps5nSm8Xn87dGq5wHMntIAC1UwfA6S4Ec0Bmt5OWTWkR2Vc24kwWpDyStk
         UpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hhhap6Yc7PpUiUD0py8cHrVh0mhGyr2EPQNKI0dXDKo=;
        b=hdG5ZpClSjRVjnII/RjP4q1eGEJHk+2QvMZ3eGbIchSgj026KFbSsnVVlP3nyvJKs4
         qlk1FM3YtZjmENcAkXb6FGYGwilv76yzN7FicCp6eXxOHiXfLAw4+MX+KIQDc5nsVdQE
         klSnPE8zfHo/W+XPNMI4vK9cvB2eVtzbl3r1cbmisC7BEYJSbqxnOwTrmHS4wH/rYnbJ
         eJz+QeOBmMpKEqf+C/y9vKOtlLvbCebhE0SOd6IIRMocmEgKHFI0Mdqx3JIBlPTJb1w+
         thtGqZhux1gLHTxQ54ekkivQGtg4uLQkx7rGe8cIXHHPWUua4Sak4lLaVh5EKEOzywRr
         U4sQ==
X-Gm-Message-State: AOAM532TE9VB2Miz3hnuShN+XlmAuIVNWfI6Vk0umve4qy5u17MV10NJ
        w9PLDZKkgiJzs0qizwzkVUvuVlfR1nk1vCqZQh5F4MHS
X-Google-Smtp-Source: ABdhPJwFODp0uHduBsVR5dsdRziifTcVU//9maBj1DK7EpB1fIlWObBGpWHc2lbWTRdw3ab5aLsX6BZfQumIoPa3xHs=
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr4114623lfp.10.1596723621653;
 Thu, 06 Aug 2020 07:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200518193617.74548-1-andriy.shevchenko@linux.intel.com>
 <CANiq72nJgGJJoUoJMxD5LTa-A7Rn1UPnr16nf8DbY9HOy7ZKEA@mail.gmail.com> <20200806095618.GA1625681@smile.fi.intel.com>
In-Reply-To: <20200806095618.GA1625681@smile.fi.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 Aug 2020 16:20:10 +0200
Message-ID: <CANiq72=_=OELWGSCMAE44UX+U3VokrnW98gUJ24rk3KBodWPEQ@mail.gmail.com>
Subject: Re: [PATCH v1] auxdisplay: charlcd: Reuse hex_to_bin() instead of
 custom code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Aug 6, 2020 at 11:56 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> May I ask which version did you have in mind? Now it's merge window for
> v5.9-rc1 and patch is still not there...

Yeah, apologies, sending it during this merge window... :-)

Cheers,
Miguel
