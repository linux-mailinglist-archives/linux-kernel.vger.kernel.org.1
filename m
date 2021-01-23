Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD46C301657
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 16:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbhAWPZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 10:25:29 -0500
Received: from ec2-3-21-30-127.us-east-2.compute.amazonaws.com ([3.21.30.127]:52120
        "EHLO www.teo-en-ming.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbhAWPXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 10:23:24 -0500
Received: from localhost (localhost [IPv6:::1])
        by www.teo-en-ming.com (Postfix) with ESMTPA id DB4D043C2F5;
        Sat, 23 Jan 2021 23:22:41 +0800 (+08)
MIME-Version: 1.0
Date:   Sat, 23 Jan 2021 23:22:41 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming.com>
To:     linux-kernel@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Subject: I have finally managed to get Windows 10 version 20H2 to work on my
 refurbished HP Elitebook 840 G1 laptop on 23 Jan 2021 Sat
Message-ID: <29171fdf8423e80467092895a1f72ea7@teo-en-ming.com>
X-Sender: ceo@teo-en-ming.com
User-Agent: Roundcube Webmail/1.2.3
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: I have finally managed to get Windows 10 version 20H2 to work 
on my refurbished HP Elitebook 840 G1 laptop on 23 Jan 2021 Sat

Good day from Singapore,

On 30 Dec 2020 Wed, I bought a refurbished/used/second hand HP Elitebook 
840 G1 laptop for SGD$250 in Singapore.

Blog Post: I have just bought a refurbished HP EliteBook 840 G1 laptop 
for SGD$250 on 30 Dec 2020 Wed
Link 1: 
http://tdtemcerts.blogspot.com/2021/01/i-have-just-bought-refurbished-hp.html
Link 2: 
https://tdtemcerts.wordpress.com/2021/01/01/i-have-just-bought-a-refurbished-hp-elitebook-840-g1-laptop-for-sgd250-on-30-dec-2020-wed/

After the purchase and upon reaching home, I formatted my laptop and 
freshly installed Windows 10 version 20H2 and version 1809 respectively. 
However, within a few minutes I would get the following message:

"System Settings Change

Your hardware settings have changed. Please reboot your computer for 
these changes to take effect."

After getting the above message, Windows 10 will then freeze/lock up 
immediately. I have no choice but to reboot. Every time I reboot, I 
would get Blue Screen of Death (BSOD) with the Inaccessible Boot Device 
error.

Blog Post: HELP! My refurbished HP Elitebook 840 G1 laptop cannot run 
Windows 10. Inaccessible Boot Device error.
Link 1: 
http://tdtemcerts.blogspot.com/2021/01/help-my-refurbished-hp-elitebook-840-g1.html
Linl 2: 
https://tdtemcerts.wordpress.com/2021/01/08/help-my-refurbished-hp-elitebook-840-g1-laptop-cannot-run-windows-10-inaccessible-boot-device-error-2/

At that point in time, I temporarily deferred troubleshooting and 
installed Fedora Workstation 33 Linux on my refurbished HP Elitebook 840 
G1 laptop instead.

Blog Post: I have installed Fedora Workstation 33 Linux on my 
refurbished HP Elitebook 840 G1 laptop because it cannot run Windows 10 
at all
Link 1: 
http://tdtemcerts.blogspot.com/2021/01/i-have-installed-fedora-workstation-33_8.html
Link 2: 
https://tdtemcerts.wordpress.com/2021/01/08/i-have-installed-fedora-workstation-33-linux-on-my-refurbished-hp-elitebook-840-g1-laptop-because-it-cannot-run-windows-10-at-all/

Today, 23 Jan 2021 Sat, I have come back to revisit the problem after a 
hiatus. After receiving inputs on the Microsoft forums some time ago, I 
decided to upgrade the BIOS/firmware of my refurbished HP Elitebook 840 
G1 laptop. The existing BIOS version is 01.20 (release 28 July 2014). I 
am going to upgrade the BIOS to the latest version 01.49 (release 24 Feb 
2020).

Unfortunately, HP support and downloads website only offer BIOS 
downloads in Windows .exe executable format. I am seriously 
inconvenienced by this because I had already installed Fedora 
Workstation 33 Linux on my refurbished HP Elitebook 840 G1 laptop. There 
is no way I can run a Windows .exe executable on a Linux operating 
system. To circumvent this problem, I have downloaded Hiren's Boot CD 
v1.0.1 ISO file and installed WoeUSB on Fedora Workstation 33 Linux. 
Using WoeUSB, I have "burned" Hiren's Boot CD ISO to a USB thumb drive. 
Then I used this USB thumb drive to boot up Hiren's Boot CD on my 
refurbished laptop. Hiren's Boot CD is a Live Windows 10 Bootable 
CD/DVD/USB operating system. Using Hiren's Boot CD, I downloaded the 
latest BIOS from HP website and proceeded to flash my firmware with BIOS 
version 01.49 (release 24 Feb 2020). With much optimism, I went ahead to 
format my laptop and freshly install Windows 10 version 20H2 again. To 
my dismay, updating the BIOS/firmware from version 01.20 (release 28 
July 2014) to version 01.49 (release 24 Feb 2020) DID NOT solve the 
problem. I am still getting Windows freezing/locking up and Inaccessible 
Boot Device BSOD error on every reboot.

I did not give up. By a stroke of good luck, I allowed Windows to do 
startup repair. When Windows 10 could not start, it automatically 
uninstalled the update causing the problem as part of its startup repair 
process. The offending update was uninstalled and I could login to 
Windows successfully. This is the message I got after logging into 
Windows:

Message: Startup Failure: “We removed some recently installed updates…”
Link: 
https://support.microsoft.com/en-us/windows/startup-failure-we-removed-some-recently-installed-updates-4c2f7448-3483-8649-843c-1e80ed9f4a00

I was given the above message but I still do not know which device 
driver or update had caused my Windows 10 to freeze and subsequently 
produce Inaccessible Boot Device BSOD error on every reboot. I may take 
a look at Windows Event Viewer/logs when I am free in the future because 
it is already 11.17 PM now at night in Singapore.

Of course, I am very happy to have managed to get Windows 10 version 
20H2 to work on my refurbished HP Elitebook 840 G1 laptop. I know 
Windows 10 will attempt to install the offending update again after 30 
days, so I am getting myself prepared by creating system restore points 
after installing drivers and software.

The following is the CORRECT order of system restore points created:

[1] Windows Update 23/1/2021 6:01:15 pm (GMT+8)

[2] After installing Intel VGA, Chrome, AVG and Zonealarm 24/1/2021 
12:04:01 pm (GMT-8)

[3] After installing Intel Chipset Driver 24/1/2021 12:20:07 pm (GMT-8)

[4] After installing Intel ME Driver 23/1/2021 8:34:37 pm (GMT+8)

[5] After installing AMD Display Driver 23/1/2021 10:12:33 pm (GMT+8)

[6] Everything working on 23 Jan 2021 23/1/2021 10:51:04 pm (GMT+8)

Please note that the dates and timings in the above list are not in the 
correct sequence because of wrong timezones being used in restore point 
#2 and #3. The correct time zone in Singapore should be GMT+8.

With the above system restore points being created, I am hoping that, if 
the offending update is going to be installed 30 days later, causing 
Windows to freeze and produce Inaccessible Boot Device BSOD error again, 
I can easily rollback my system to a working restore point without too 
much of a hassle.

Thank you.







-- 
-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: 
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's 
Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the 
United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan (5 Aug 
2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
