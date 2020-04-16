Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5317B1AD145
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 22:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbgDPUiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 16:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgDPUiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:38:21 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7557E2220A;
        Thu, 16 Apr 2020 20:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587069500;
        bh=9i3CfymeGe/NEpMGnyUqethDDHOzRWWGJhLiiXR7+QU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AtYRlm3JeEbYNmK1uFVhGVztI222HVj0FYwHr9mzeclmUYYZuRqTLCpQSm86Z7sc+
         Du0qNp5IZ0S8HL2Hch2Cqk9T6fxX/q4QaM3OPYLhsccpaNS9nI9FuK8u3ZO5VRHeaJ
         coliPMrSFWdwbUFi9HGRYwz/F4taGg50ckffHISM=
Received: by mail-qt1-f171.google.com with SMTP id b10so59049qtt.9;
        Thu, 16 Apr 2020 13:38:20 -0700 (PDT)
X-Gm-Message-State: AGi0PuaYL/mneGQ4+9jemTNYXirtiDM9x2OzMejLLG9mlMOsFyMhLqoP
        Ah2DSLuRgPp9Y4nQnTfDnI7eBAzH4pclhikF0Q==
X-Google-Smtp-Source: APiQypINcM/3te3/8Ff4YCoykqXgpcs+an4Ryq2/zxonzK/oqiiErlVLJql23/90o1z0HIyweV5zlL9XqTC+jP72nKw=
X-Received: by 2002:ac8:4907:: with SMTP id e7mr28608227qtq.300.1587069499594;
 Thu, 16 Apr 2020 13:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <1587012974-21219-1-git-send-email-gupt21@gmail.com>
In-Reply-To: <1587012974-21219-1-git-send-email-gupt21@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 Apr 2020 15:38:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLWMTpHG=bOmWgy1kg6d7vxRGbCda+febq=FnqbuRbPyQ@mail.gmail.com>
Message-ID: <CAL_JsqLWMTpHG=bOmWgy1kg6d7vxRGbCda+febq=FnqbuRbPyQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: ttyvs: document serial null modem
 driver bindings
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:56 PM Rishi Gupta <gupt21@gmail.com> wrote:
>
> The ttyvs driver creates virtual tty devices. These devices can
> also be created through device tree. This commit document this.

Device tree is for real h/w devices. You have a configfs interface to
set these up. I don't think we need both.

Rob
