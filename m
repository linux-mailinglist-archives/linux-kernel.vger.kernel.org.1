Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 093B11A5F29
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 17:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgDLPCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 11:02:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40066 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgDLPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 11:02:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id a81so7640029wmf.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0yqa+EKJqOMZqIixsYzmlt55IzP82TkpcbHu7uxFT4o=;
        b=i7Z8LvyenibZTZyXkEsEEE3K8RDOujJ5674sYvNfURpQHNE2oBiWWT7e/r2jmyhWQD
         y1+2fnERImX69QvnWOISWrNrpamrprTbjTLcqfhrku9LoEMEmGG9qEuMsikEqSsaxSqK
         Y79t6ml2mxu6Bg8wZRcptCDJfETVDXs2SZK8GQltSXQNOiaJe/6CdZyheSlXoFomAFYU
         BHejmk7ZGe37MV75QLmNKF23jBsXVadUdm/DzLwRTeJn8gbN5K6kRtSZybzhaMVIOrrG
         kkpACiuBfCAkHXBTZasQv7jicUw7dN29mk5V0RP+E4nBX49iA5hmeuiTzHvVhCaBoAUV
         g05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0yqa+EKJqOMZqIixsYzmlt55IzP82TkpcbHu7uxFT4o=;
        b=VIOkYaW79z3Re9BNkht9zb9R0LYFCEfEh/JKVIjzzd6FZVe3qQucAI00ftsxb0L3LQ
         2CA0Hqhje27BnvC/0+p91iZohsNBQIDq1kEgXhDn0aNpbxdIGqT3KHxXEFBoB1vJjTbS
         qkwPlJLtCys0NsdXFDMTJ4oUG8qAb9o3OuyN6m5xf0NO+WE5Y655xgZv7GBni7YsGbB/
         PtzPfy93CsazyglPy+9fIr2dtXuSpxL0vCv1qoVw90vWUkRaWPLKKj10ypE13fgb30A3
         DIVw+J154NdBz4Z9ZMK0/Vb0IW4PUIxDjw7TIgchqnxmW1zPRV3IbObqJKPboNies62t
         1ANg==
X-Gm-Message-State: AGi0PuZo8mVWza+kvBY9fM8N3NWIujE6evGeQlzUR+NvIep72vo5T1s8
        BRVSx0JHcNhyBNNaOC1xVr1Psg==
X-Google-Smtp-Source: APiQypJ5G4BL6g1G/EhYOU8fMFTZs+je8F9lWXNuf0JLZA90eJeTelxDQNlTSUguKI6gLklzRQKBzw==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr14005777wme.159.1586703750678;
        Sun, 12 Apr 2020 08:02:30 -0700 (PDT)
Received: from ?IPv6:2001:1715:4e3a:130:cca:5c89:8758:a721? ([2001:1715:4e3a:130:cca:5c89:8758:a721])
        by smtp.gmail.com with ESMTPSA id i13sm5808364wro.50.2020.04.12.08.02.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 08:02:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.5\))
Subject: Re: [PATCH] selftests/tpm2: Change exception handling to be Python 3
 compatible
From:   Ezra Buehler <ezra@easyb.ch>
In-Reply-To: <20200412143656.72955-1-jarkko.sakkinen@linux.intel.com>
Date:   Sun, 12 Apr 2020 17:02:27 +0200
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FE03B4F-C42C-4B5F-A4B5-8169705911FA@easyb.ch>
References: <20200412143656.72955-1-jarkko.sakkinen@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-Mailer: Apple Mail (2.3445.9.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkkon,

> On 12 Apr 2020, at 16:36, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
> +        except ProtocolError(e):

Should this not be

        except ProtocolError as e:

?

Cheers,
Ezra.

