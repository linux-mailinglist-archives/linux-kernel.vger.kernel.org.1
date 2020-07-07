Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9570821784F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 21:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgGGTwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 15:52:06 -0400
Received: from smtp114.iad3a.emailsrvr.com ([173.203.187.114]:43095 "EHLO
        smtp114.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726951AbgGGTwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1594151521;
        bh=EtQXgiskvrmcRf9wNzmGtIzZoRnsw2CxrLx1nXjgTEo=;
        h=Date:Subject:From:To:From;
        b=adHG4Sn55+RmvYyBdHm93qvP4WbTDbxd76IthLQNOdq1GAs0L5iX/r07Gsrq+q5yp
         MOPv2n8NRS2KnA7g5pZF0/XrIL3RWU+kCdeaI6B7X8MMd/EGNlLMjVqEVIgUh76CEy
         7vj6np1FNrkKvNeHLhNsLl+BXEDOlTSRSQrvVL+4=
Received: from app12.wa-webapps.iad3a (relay-webapps.rsapps.net [172.27.255.140])
        by smtp31.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id A177924886;
        Tue,  7 Jul 2020 15:52:01 -0400 (EDT)
Received: from deepplum.com (localhost.localdomain [127.0.0.1])
        by app12.wa-webapps.iad3a (Postfix) with ESMTP id 87C25E0059;
        Tue,  7 Jul 2020 15:52:01 -0400 (EDT)
Received: by apps.rackspace.com
    (Authenticated sender: dpreed@deepplum.com, from: dpreed@deepplum.com) 
    with HTTP; Tue, 7 Jul 2020 15:52:01 -0400 (EDT)
X-Auth-ID: dpreed@deepplum.com
Date:   Tue, 7 Jul 2020 15:52:01 -0400 (EDT)
Subject: Re: [PATCH v3 2/3] Fix undefined operation fault that can hang a cpu on crash or panic
From:   "David P. Reed" <dpreed@deepplum.com>
To:     "Sean Christopherson" <sean.j.christopherson@intel.com>
Cc:     "Andy Lutomirski" <luto@amacapital.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "X86 ML" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Allison Randal" <allison@lohutok.net>,
        "Enrico Weigelt" <info@metux.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        "=?utf-8?Q?Peter_Zijlstra_=28Intel=29?=" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Martin Molnar" <martin.molnar.programming@gmail.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Alexandre Chartre" <alexandre.chartre@oracle.com>,
        "Jann Horn" <jannh@google.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Importance: Normal
X-Priority: 3 (Normal)
X-Type: plain
In-Reply-To: <20200707192455.GI20096@linux.intel.com>
References: <20200629214956.GA12962@linux.intel.com> 
 <20200704203809.76391-1-dpreed@deepplum.com> 
 <20200704203809.76391-3-dpreed@deepplum.com> 
 <20200707050932.GF5208@linux.intel.com> 
 <1594148978.965916054@apps.rackspace.com> 
 <20200707192455.GI20096@linux.intel.com>
Message-ID: <1594151521.553815968@apps.rackspace.com>
X-Mailer: webmail/17.3.12-RC
X-Classification-ID: 7af768d6-d92a-4734-a147-d86d4dabcbb8-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=0AOn Tuesday, July 7, 2020 3:24pm, "Sean Christopherson" <sean.j.christ=
opherson@intel.com> said:=0A=0A> On Tue, Jul 07, 2020 at 03:09:38PM -0400, =
David P. Reed wrote:=0A>>=0A>> On Tuesday, July 7, 2020 1:09am, "Sean Chris=
topherson"=0A>> <sean.j.christopherson@intel.com> said:=0A>> Sean, are you =
the one who would get this particular fix pushed into Linus's=0A>> tree, by=
 the way? The "maintainership" is not clear to me.=0A> =0A> Nope, I'm just =
here to complain and nitpick :-)  There's no direct maintainer=0A> for virt=
ext.h so it falls under the higher level arch/x86 umbrella, i.e. I=0A> expe=
ct Boris/Thomas/Ingo will pick this up.=0A> =0AThanks for your time and eff=
ort in helping.

