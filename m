Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2ED1D239D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 02:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733106AbgENA21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 20:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732946AbgENA21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:28:27 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF8FC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:28:26 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so507974pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=/OgFWQcl6GqLh70sxVH11v5JkzFPDxSBTU/nOH/MDE0=;
        b=BHnzOpZ4aPuXZ4y4SiBIhfTt3B49rsvbpJmsylMOyVg9evwgE/8f6zVeYX4Kfy13ju
         Z3KIUPf0JfMxqUSjKIhCrBDludl9XLA7mfefFHVi1ntb/1+3bJoLlTal76guWAnUSqGt
         HE3SSLoxxSOEHXpbtNSYoB8HNFxD7IxnBRRE+s2DaEWYSA2kJxnrd+ZJIBq14VYlBYFH
         OPSQ7X/61B7QPjJZQ2H31IYpM1t54Ro4SCLjRYOJZt/ZVJys4E83Y7rONE8/JWsdiNg2
         uFnk9WBknjkS/eF+vfC2yu9hVMSRYadUA4+LsYq52JrPmFSxZFYIXEES5r9P+tddTIV8
         szRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=/OgFWQcl6GqLh70sxVH11v5JkzFPDxSBTU/nOH/MDE0=;
        b=D4tVwn909ePM9Kdk7F+KEqRDvhOEDcMVQ/h+TJMJTAY4rOgzmuX8mfHvM0mVaH9hI4
         JQ5K1Z5mdaKI/5VFEHK4xhoNXza6RKmYktQ7UI4Is1awqVHjVExBhBC5dObMzaTjL7on
         4o+i6xEAPzt3CItUJqRDv3s2NB5yjurnOzS21bfe+z3tgaPPO1gs353RuHWYJZ8KAVsE
         /JuHqv3OG9lbrccEVnXB0sETWKrALACB+6cDlpj/TRWev6iEx0m/tC/WVMwAzrs090mq
         sP1lNUbxQpWGfAEPuJU6LtlQ++15Jtz6S+aVLV1Z+zChJQs9wzXQX4RGMWSvBq7SWsuw
         bF1g==
X-Gm-Message-State: AOAM531oSIRJ8XZqbnXM7I3ylOlP+2NgHjEulvcD3AWAnlDVssMKg60v
        F5URtIHNO5lGOkl2SOGmUzu4Zhejo2o=
X-Google-Smtp-Source: ABdhPJyfQiKngEQA41ugpWVwsMyP0DyUIcBpI9LEiTAFMNFmhOt/49ftEYNWPohSlNJYLaFWt3g3rg==
X-Received: by 2002:a65:480c:: with SMTP id h12mr1824385pgs.106.1589416106079;
        Wed, 13 May 2020 17:28:26 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g43sm16612227pje.22.2020.05.13.17.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 17:28:25 -0700 (PDT)
Date:   Wed, 13 May 2020 17:28:25 -0700 (PDT)
X-Google-Original-Date: Wed, 13 May 2020 17:13:28 PDT (-0700)
Subject:     Re: linux-next: Signed-off-by missing for commit in the risc-v-fixes tree
In-Reply-To: <20200513211925.030deeec@canb.auug.org.au>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-ae684228-c7f9-48a1-aa4d-8fe166efe5ab@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 04:19:25 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> Commit
>
>   e2d8d84b18c3 ("riscv: pgtable: Fix __kernel_map_pages build error if NOMMU")
>
> is missing a Signed-off-by from its committer.

Thanks.  I had to manually apply this and must have forgotten -s, it's fixed now.
