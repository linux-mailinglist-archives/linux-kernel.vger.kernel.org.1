Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024842D957E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 10:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgLNJti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:49:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45705 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgLNJtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:49:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id x20so9010827lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:48:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XI8TdlR3KcMv59VM3giX3zxtKyG7BK96h7ee6Dtc+Hc=;
        b=bpdamnk1VbV1SZYhOCdKrUP2xTC33YYi/V8QvulW8+GXdgLC0sjMXPRQuWpscngDCw
         P3mdd8O+dfdBh4ioOusDQ9l0jCMxymH2OeCXCfdHTbchJ86VVs+xmx8eZbT1CJwujKmm
         gxqF5Yk8MAhk/I2A6E350fEtJAFRnQ8eV1Q8KCG0yA6U2UN5baUmyowpGzOu/xvv5j0P
         mi2mD9nVPoP2CEHmavDNgGGgbyLArBZB/eF1TIpKB/vG8Po3cTBnq3cIc0+N/A86wLVC
         eOj+pwcgbwM7Huj84dnVX1KsjvtIZ/eavYd+VrMweNI1QlirWg4KYkynDujhjBhysOhE
         swKQ==
X-Gm-Message-State: AOAM531OWBBOhrhgsncVrJ8msZW9v6r6w1Pz9qsfGW8au/Sa3A5Uc1Ki
        1U378ECeUD82xGGLmCKiIvskQoLGk6s45g==
X-Google-Smtp-Source: ABdhPJzoXnESclP7EEY5c7fTHL1+1OzuylVaGV8TahwEqlVO46WsRCD6UF4zYmlvyqmYFwYCQk0Iqw==
X-Received: by 2002:a2e:4c11:: with SMTP id z17mr8151164lja.364.1607939312667;
        Mon, 14 Dec 2020 01:48:32 -0800 (PST)
Received: from xi.terra (c-b3cbe455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.203.179])
        by smtp.gmail.com with ESMTPSA id f19sm1795161ljm.7.2020.12.14.01.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 01:48:31 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kokSx-0006f4-S3; Mon, 14 Dec 2020 10:48:27 +0100
Date:   Mon, 14 Dec 2020 10:48:27 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "wanghai (M)" <wanghai38@huawei.com>
Cc:     Johan Hovold <johan@kernel.org>, vaibhav.sr@gmail.com,
        elder@kernel.org, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com, aibhav.sr@gmail.com,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: audio: Fix possible leak free widgets
 in gbaudio_dapm_free_controls
Message-ID: <X9c06wvYreO2h8uP@localhost>
References: <20201205103827.31244-1-wanghai38@huawei.com>
 <X89IxvbYWjuyaQDT@localhost>
 <ed57715b-c524-4726-3eaf-434af96d2d92@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed57715b-c524-4726-3eaf-434af96d2d92@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 08:29:22PM +0800, wanghai (M) wrote:
> 
> 在 2020/12/8 17:35, Johan Hovold 写道:
> > On Sat, Dec 05, 2020 at 06:38:27PM +0800, Wang Hai wrote:
> >> In gbaudio_dapm_free_controls(), if one of the widgets is not found, an error
> >> will be returned directly, which will cause the rest to be unable to be freed,
> >> resulting in leak.
> >>
> >> This patch fixes the bug. If if one of them is not found, just skip and free the others.
> > Apart from the typo, please break your lines at 72 columns or so (not
> > needed for the Fixes tag).
>
> Thanks for review,  Do I need to send a v2 patch to change the commit msg?

I'm not sure your mail reached the lists since it contains HTML, but to
answer your question: Please do resend. If you can make the maintainers'
life any easier that's always a good idea.

You should include the Reviewed-by tags you've gotten so far when
resending as long as you only update the commit message.

Johan
