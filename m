Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7F2274BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgIVVyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgIVVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:54:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FD3C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 14:54:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so8908528pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 14:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qY9B3lmgcCoR+aK4b750bpoEi3TcWLnOwBpI2hl6Rb0=;
        b=04nYlHZlFfW9k7c825u5ros7u4MMBkpYAesHAaexEctsz7Hf5fDkeYF+E3GfFVtHYo
         1yiw34S3gIFPtFhLHWtbcSfLUFOgcZizW//K9T1M+4UIVlpiFqREDKPZ5Xc6pfyy81M5
         j2LX3oqhXHPckWOQlTqokLK01iXnnRCI8erYVN4K8yjWHFJzhjA1RvpxxCKy2sp3oj+U
         8xvtP7PTY+FHwSTSfDPAB8nWHeaLKwPg96Ws7zDTwFpN6xcLSNJ1tcB8iFBGv1l9Qhi7
         Dc+wOYGCJa+b92HMO8OEmwMXk6yIbUYJXKP9oEy1k9o4kyidW3+VJSTdDK1/u11yOdJg
         vOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qY9B3lmgcCoR+aK4b750bpoEi3TcWLnOwBpI2hl6Rb0=;
        b=ciF6TB18CvKB5nl8spk2dGiK1hF8ijnzCCJ0d4IiM7vtktN/5avwJC9J+bZ3qeTEob
         njQTElDlJntxTF+q8o9flUfihRU98DS8+XJLoaBg2EqYwLMW9ZKO+Fd7+zktp8atgjNo
         ynFmZH2i/qVUyDKf/m/Cq1uOEDuUNh3HqiuHhKAB7/vTg3uyZXavV94ymcJ6gKIacahT
         5Tgq72nEus5rb+lAz5QCk7wzicA1VOLNcBBF1NqxAg/z4ltLqEEip9e1dO37vv9ZRqQj
         VLcjzggPsZGih8C8MD6DIolh2SkwNAwvIRg01Q6Bkvy8uqUCGJ6TGS6BvVEbOHdCujVD
         2k5w==
X-Gm-Message-State: AOAM5313U3fHwMUa4L7gwjVozmDZTRgynkQhMa4TgNGXHpdqgmC0Hx1S
        yk2LY8dd1/eUBevsiIBGnsjD7w==
X-Google-Smtp-Source: ABdhPJxGl1af56HiYGbgyi5nOFAPToHeEdjiFOMS6GVG7s8Nuo7aFP+GU8lamoVCoajHLlS1pVuhfA==
X-Received: by 2002:a17:902:7c0c:b029:d1:f38b:713b with SMTP id x12-20020a1709027c0cb02900d1f38b713bmr6792319pll.44.1600811646298;
        Tue, 22 Sep 2020 14:54:06 -0700 (PDT)
Received: from [10.251.0.32] (jfdmzpr03-ext.jf.intel.com. [134.134.139.72])
        by smtp.gmail.com with ESMTPSA id g9sm16327993pfo.144.2020.09.22.14.54.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 14:54:05 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] PCI/RCEC: Cache RCEC capabilities in
 pci_init_capabilities()
Date:   Tue, 22 Sep 2020 14:54:03 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <7ACD5D29-0A52-4940-8AA9-198F83F3C390@intel.com>
In-Reply-To: <20200922204533.GA2228232@bjorn-Precision-5520>
References: <20200922204533.GA2228232@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Sep 2020, at 13:45, Bjorn Helgaas wrote:

> I don't know what's going on with email, but I only see patches 3, 5,
> 6, 9 on the list and on lore:
> https://lore.kernel.org/r/20200918204603.62100-4-sean.v.kelley@intel.co=
m/
>
> Similar issues with Sathy's series, where I only see patches 1, 3, 5:
> https://lore.kernel.org/r/a640e9043db50f5adee8e38f5c60ff8423f3f598.1600=
457297.git.sathyanarayanan.kuppuswamy@linux.intel.com/

We are still affected by issues with handshaking between smtp server and =

external lists.  I just resent after bumping to fix, and I=E2=80=99m swit=
ching =

to my personal account seanvk.dev@oregontracks.org

https://lore.kernel.org/linux-pci/20200922213859.108826-1-seanvk.dev@oreg=
ontracks.org/


Apologies for the inconvenience.

Sean

>
> On Fri, Sep 18, 2020 at 01:45:56PM -0700, Sean V Kelley wrote:
>> Extend support for Root Complex Event Collectors by decoding and
>> caching the RCEC Endpoint Association Extended Capabilities when
>> enumerating. Use that cached information for later error source
> ...
