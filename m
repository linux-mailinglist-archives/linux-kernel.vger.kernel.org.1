Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AB52A24B6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 07:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgKBGSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 01:18:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:59049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgKBGSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 01:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604297922;
        bh=lvHBq85Gbc0OxKBrJbmGxJOVRF4oGwEf7Lha15Jmgp4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=SjHhWwv6y3+RgM2bxEjwAt/Btg0uTgO1ziLvgcu3orrsuNEPOuV6Gi4iENk5JGlye
         9DaCj8XjJVH1OF0V86ZOUfHaFw7i1jOAH3xxxuz0cbpoZGa/pDlRIvgKMHRjpcHp5Q
         ftqKBxttHU8CKNI6XIKen0zWyrnklSt81lBTJBw8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.216.249]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyyk-1kBlau23Fu-00x6pH; Mon, 02
 Nov 2020 07:18:42 +0100
Message-ID: <59d0b9516ce9a553b1e526c6495ac302f1f73e0d.camel@gmx.de>
Subject: Re: v5.8+ powersave governor breakage?
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Mon, 02 Nov 2020 07:18:41 +0100
In-Reply-To: <580d12716f6363d7404805fd4bc50e2d5ab459b0.camel@gmx.de>
References: <580d12716f6363d7404805fd4bc50e2d5ab459b0.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SXWRwT2VsnWTG9wtARIfas/ghOSBG4zy6+E+Kub0XHQliYjY59Z
 NFaLZ4+BzgPm8p/oD2rsnz94OWF90vDgZZkwU+O7CTPUQ549tKyyW29NwSylqfYHf31nYDB
 XtFeX9igTLKWox4Ap1uwlZwOdBL0QaGq/Xe+4V+EydCBFvzq8iakxXU7VjJ/YjP8PhHhu7b
 +dUizvCKxcL/0oHyZ04TA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4VHVqYGNEfE=:oML2Dny8o6/DN5UORAXtYp
 YWxf4kCXxZLeX2lhvUWcIz/wq0safdtwlRbAcAw0abB1NG+5cZ6zigywlrJ9zUEEqOVgPOGPT
 5z2kX51s6g0rmqcqmNb3nAEZpPidgraqcDisIx5YheTqYR/hNSnLTBuZNF9RjUrR3ipP1RDse
 lAyaXsAAC8vP+RTn85RYjH65q9JO3rQVGUACgbfIPqmKVZM47tNQ1nwl20LKhDYhUS9NoE1Ty
 LmAZ86pyTK+kZ6og0cEIVXi8FWA/S9q/J5W8hILQBj3wDqzqggbCZx/DkK9+8dA6oDcVBD2jv
 vH/iRzo/uqdGpBwaD02+MrOyC44vLh1WN0mvdScAkoAq0vC+qu4gh/CodZc0VGWs+1Y4yWVC5
 XQjx0aNLz6OP+GvkSR+ivBUi5+DeJZ/qa5B+LPZz3DrXWX9RJf5igrgCc/98BGny0k4TUrrp9
 G7RffHmZZc24QrSzkWZ1UXXapKmKUIhrJ/kdEadL4LS1/4o6ApyoBezT41Pshb+7oZS8DQGp3
 gYjsPBlydplXrJdZSQCz2eU+CeEZq4UW8Bmt6K2alOJZB6F0uSl6IjWs7pfoXkIinJp0paWil
 yc2/fjUOpxfk7VG9HzbrKO2i0OYiiKji7DJG2np9YOgMh0yAro/oai5kiQK81G8RodyPA0IHz
 RAkcP/jR6jV12QxXHru4zzYHlCa7YApjIiDKst240LdwH1C9lrKkWyblSry9Tpjnx9FIcPsLv
 PYe3phWykU3PW0CcQeL/u40qqPqEq2qwuNIaDK97rB2KpVy6lxle3JUP1ffmbIlSHO4Bg4p9E
 T3XhI1JtILj2npFNX0axZs1aNWWr5JXhruauV8+qrsXdAwYt6/PbPkcpUPXKm2ff1Lx8FAuWP
 BUOMlk7++zL5sLmnMrwA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-01 at 17:23 +0100, Mike Galbraith wrote:
> Greetings,
>
> As you can see in the data below, my i4790 box used to default to the
> powersave governor despite CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy, and
> disallowed switching to ondemand.

Ok, my HP lappy running master.today still defaults to powersave, with
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=3Dy, still disallows selecting
ondemand as before, and powersave still works. IOW for lappy, it was
business as usual, no change.

Desktop box did, it gained a working ondemand, while its previously
working powersave went broke. Box had schedutil forced upon it, but it
seems perfectly fine with that performance wise.

	-Mike

