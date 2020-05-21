Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE961DD05D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 16:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgEUOmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 10:42:33 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:43359 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbgEUOmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:42:32 -0400
Date:   Thu, 21 May 2020 14:42:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1590072151;
        bh=5QT3ozfWcrDejI0SGJuAQmXXo/lvctQ8f3juXhOhWLc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=VOSTfDeiTZAhLr1uwY3qopK9+8Po5cvojbSeN5TiLsIQrFQAC4mygWQjt0lMVQxfa
         b0teiU5S5ySrgdGRsXwAp3xOennTBF+QVO9ck+j/kpxlihB4SD3QSuGpPTKYGy7ys/
         VI3bc8ouTV/gBOeM9yBzh0iSMGVwZs+YAV1xHJ/A=
To:     Thomas Gleixner <tglx@linutronix.de>
From:   Krzysztof Piecuch <piecuch@protonmail.com>
Cc:     "linux-kernel\\\\\\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo\\\\\\@redhat.com" <mingo@redhat.com>,
        "bp\\\\\\@alien8.de" <bp@alien8.de>,
        "hpa\\\\\\@zytor.com" <hpa@zytor.com>,
        "x86\\\\\\@kernel.org" <x86@kernel.org>,
        "rafael.j.wysocki\\\\\\@intel.com" <rafael.j.wysocki@intel.com>,
        "drake\\\\\\@endlessm.com" <drake@endlessm.com>,
        "viresh.kumar\\\\\\@linaro.org" <viresh.kumar@linaro.org>,
        "juri.lelli\\\\\\@redhat.com" <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mzhivich\\\\\\@akamai.com" <mzhivich@akamai.com>,
        "malat\\\\\\@debian.org" <malat@debian.org>
Reply-To: Krzysztof Piecuch <piecuch@protonmail.com>
Subject: Re: [PATCH] x86/tsc: Add tsc_early_khz command line parameter overriding early TSC calibration
Message-ID: <lOHOPnM3pobUS8nKbA1uWAJqWkHj3CaQtmiaYCrf-2Bn13RZgsl8FWyKyGSCgLfIQIPeHP71CZT2lGZmUMFJBFhLtIpQeilTINbv54SrRvw=@protonmail.com>
In-Reply-To: <87h80at4gt.fsf@nanos.tec.linutronix.de>
References: <O2CpIOrqLZHgNRkfjRpz_LGqnc1ix_seNIiOCvHY4RHoulOVRo6kMXKuLOfBVTi0SMMevg6Go1uZ_cL9fLYtYdTRNH78ChaFaZyG3VAyYz8=@protonmail.com>
 <WIxfn1FPETITrmzdhnFHwujR0uEbHZ44PWZgmtRAzmj4rJ4wfzQUbcSWMtneOk0p7HkbJubs0z1BSLaBY3IXJarup8Ukw7Kv0WWYNgPk5bo=@protonmail.com>
 <87h80at4gt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, February 1, 2020 8:52 PM, Thomas Gleixner <tglx@linutronix.de>=
 wrote:
> It's in my backlog and todo list

Hi, I just wanted to check if there's an ETA on this?

Thanks,
Krzysztof Piecuch
