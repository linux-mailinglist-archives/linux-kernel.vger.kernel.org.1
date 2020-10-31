Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889442A1B4D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 00:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgJaX5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 19:57:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:23718 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbgJaX5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 19:57:50 -0400
IronPort-SDR: /tWEOP+lMYhfvk8u7V2DJRVF8itL2FVug2BmGeJmsl14gZU3c1k33ZBwW4Km+9NpvNXq3bP4Z5
 Ig7V9rjFG0XA==
X-IronPort-AV: E=McAfee;i="6000,8403,9791"; a="253464524"
X-IronPort-AV: E=Sophos;i="5.77,439,1596524400"; 
   d="gz'50?scan'50,208,50";a="253464524"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2020 16:57:48 -0700
IronPort-SDR: hK070n76kzFTJFe2pX3kkyI2xDR3etjoxNtYPghyW4RjnPu2QpJHk4Z0olKi7eTTkM/CyS15/9
 lMqC7UQuWBgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,439,1596524400"; 
   d="gz'50?scan'50,208,50";a="395820236"
Received: from lkp-server02.sh.intel.com (HELO ee7b80346e9c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 31 Oct 2020 16:57:46 -0700
Received: from kbuild by ee7b80346e9c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kZ0kj-0000FY-Jy; Sat, 31 Oct 2020 23:57:45 +0000
Date:   Sun, 1 Nov 2020 07:57:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jordan Niethe <jniethe5@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alistair Popple <alistair@popple.id.au>
Subject: arch/powerpc/lib/sstep.c:1172:21: error: variable 'suffix' set but
 not used
Message-ID: <202011010714.8NdJB3Ng-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jordan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2dc4c073fb71b50904493657a7622b481b346e3
commit: 650b55b707fdfa764e9f2b81314d3eb4216fb962 powerpc: Add prefixed instructions to instruction data type
date:   6 months ago
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=650b55b707fdfa764e9f2b81314d3eb4216fb962
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 650b55b707fdfa764e9f2b81314d3eb4216fb962
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/lib/sstep.c: In function 'analyse_instr':
>> arch/powerpc/lib/sstep.c:1172:21: error: variable 'suffix' set but not used [-Werror=unused-but-set-variable]
    1172 |  unsigned int word, suffix;
         |                     ^~~~~~
   arch/powerpc/lib/sstep.c:1168:31: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]
    1168 |  unsigned int opcode, ra, rb, rc, rd, spr, u;
         |                               ^~
   cc1: all warnings being treated as errors

vim +/suffix +1172 arch/powerpc/lib/sstep.c

  1153	
  1154	/*
  1155	 * Decode an instruction, and return information about it in *op
  1156	 * without changing *regs.
  1157	 * Integer arithmetic and logical instructions, branches, and barrier
  1158	 * instructions can be emulated just using the information in *op.
  1159	 *
  1160	 * Return value is 1 if the instruction can be emulated just by
  1161	 * updating *regs with the information in *op, -1 if we need the
  1162	 * GPRs but *regs doesn't contain the full register set, or 0
  1163	 * otherwise.
  1164	 */
  1165	int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
  1166			  struct ppc_inst instr)
  1167	{
  1168		unsigned int opcode, ra, rb, rc, rd, spr, u;
  1169		unsigned long int imm;
  1170		unsigned long int val, val2;
  1171		unsigned int mb, me, sh;
> 1172		unsigned int word, suffix;
  1173		long ival;
  1174	
  1175		word = ppc_inst_val(instr);
  1176		suffix = ppc_inst_suffix(instr);
  1177	
  1178		op->type = COMPUTE;
  1179	
  1180		opcode = ppc_inst_primary_opcode(instr);
  1181		switch (opcode) {
  1182		case 16:	/* bc */
  1183			op->type = BRANCH;
  1184			imm = (signed short)(word & 0xfffc);
  1185			if ((word & 2) == 0)
  1186				imm += regs->nip;
  1187			op->val = truncate_if_32bit(regs->msr, imm);
  1188			if (word & 1)
  1189				op->type |= SETLK;
  1190			if (branch_taken(word, regs, op))
  1191				op->type |= BRTAKEN;
  1192			return 1;
  1193	#ifdef CONFIG_PPC64
  1194		case 17:	/* sc */
  1195			if ((word & 0xfe2) == 2)
  1196				op->type = SYSCALL;
  1197			else
  1198				op->type = UNKNOWN;
  1199			return 0;
  1200	#endif
  1201		case 18:	/* b */
  1202			op->type = BRANCH | BRTAKEN;
  1203			imm = word & 0x03fffffc;
  1204			if (imm & 0x02000000)
  1205				imm -= 0x04000000;
  1206			if ((word & 2) == 0)
  1207				imm += regs->nip;
  1208			op->val = truncate_if_32bit(regs->msr, imm);
  1209			if (word & 1)
  1210				op->type |= SETLK;
  1211			return 1;
  1212		case 19:
  1213			switch ((word >> 1) & 0x3ff) {
  1214			case 0:		/* mcrf */
  1215				op->type = COMPUTE + SETCC;
  1216				rd = 7 - ((word >> 23) & 0x7);
  1217				ra = 7 - ((word >> 18) & 0x7);
  1218				rd *= 4;
  1219				ra *= 4;
  1220				val = (regs->ccr >> ra) & 0xf;
  1221				op->ccval = (regs->ccr & ~(0xfUL << rd)) | (val << rd);
  1222				return 1;
  1223	
  1224			case 16:	/* bclr */
  1225			case 528:	/* bcctr */
  1226				op->type = BRANCH;
  1227				imm = (word & 0x400)? regs->ctr: regs->link;
  1228				op->val = truncate_if_32bit(regs->msr, imm);
  1229				if (word & 1)
  1230					op->type |= SETLK;
  1231				if (branch_taken(word, regs, op))
  1232					op->type |= BRTAKEN;
  1233				return 1;
  1234	
  1235			case 18:	/* rfid, scary */
  1236				if (regs->msr & MSR_PR)
  1237					goto priv;
  1238				op->type = RFI;
  1239				return 0;
  1240	
  1241			case 150:	/* isync */
  1242				op->type = BARRIER | BARRIER_ISYNC;
  1243				return 1;
  1244	
  1245			case 33:	/* crnor */
  1246			case 129:	/* crandc */
  1247			case 193:	/* crxor */
  1248			case 225:	/* crnand */
  1249			case 257:	/* crand */
  1250			case 289:	/* creqv */
  1251			case 417:	/* crorc */
  1252			case 449:	/* cror */
  1253				op->type = COMPUTE + SETCC;
  1254				ra = (word >> 16) & 0x1f;
  1255				rb = (word >> 11) & 0x1f;
  1256				rd = (word >> 21) & 0x1f;
  1257				ra = (regs->ccr >> (31 - ra)) & 1;
  1258				rb = (regs->ccr >> (31 - rb)) & 1;
  1259				val = (word >> (6 + ra * 2 + rb)) & 1;
  1260				op->ccval = (regs->ccr & ~(1UL << (31 - rd))) |
  1261					(val << (31 - rd));
  1262				return 1;
  1263			}
  1264			break;
  1265		case 31:
  1266			switch ((word >> 1) & 0x3ff) {
  1267			case 598:	/* sync */
  1268				op->type = BARRIER + BARRIER_SYNC;
  1269	#ifdef __powerpc64__
  1270				switch ((word >> 21) & 3) {
  1271				case 1:		/* lwsync */
  1272					op->type = BARRIER + BARRIER_LWSYNC;
  1273					break;
  1274				case 2:		/* ptesync */
  1275					op->type = BARRIER + BARRIER_PTESYNC;
  1276					break;
  1277				}
  1278	#endif
  1279				return 1;
  1280	
  1281			case 854:	/* eieio */
  1282				op->type = BARRIER + BARRIER_EIEIO;
  1283				return 1;
  1284			}
  1285			break;
  1286		}
  1287	
  1288		/* Following cases refer to regs->gpr[], so we need all regs */
  1289		if (!FULL_REGS(regs))
  1290			return -1;
  1291	
  1292		rd = (word >> 21) & 0x1f;
  1293		ra = (word >> 16) & 0x1f;
  1294		rb = (word >> 11) & 0x1f;
  1295		rc = (word >> 6) & 0x1f;
  1296	
  1297		switch (opcode) {
  1298	#ifdef __powerpc64__
  1299		case 2:		/* tdi */
  1300			if (rd & trap_compare(regs->gpr[ra], (short) word))
  1301				goto trap;
  1302			return 1;
  1303	#endif
  1304		case 3:		/* twi */
  1305			if (rd & trap_compare((int)regs->gpr[ra], (short) word))
  1306				goto trap;
  1307			return 1;
  1308	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--n8g4imXOkfNTN/H1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--n8g4imXOkfNTN/H1--
